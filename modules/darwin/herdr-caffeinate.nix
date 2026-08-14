{ pkgs, ... }:

# Keep the Mac awake while a herdr agent is actively working.
# A launchd user agent polls `herdr agent list` and holds a `caffeinate`
# process for as long as at least one agent reports the `working` status.
let
  interval = 20;

  supervisor = pkgs.writeShellScript "herdr-caffeinate" ''
    set -u

    herdr=${pkgs.herdr}/bin/herdr
    jq=${pkgs.jq}/bin/jq
    caffeinate=/usr/bin/caffeinate

    caff_pid=""

    stop_caffeinate() {
      if [ -n "$caff_pid" ] && kill -0 "$caff_pid" 2>/dev/null; then
        kill "$caff_pid" 2>/dev/null || true
      fi
      caff_pid=""
    }

    trap 'stop_caffeinate; exit 0' TERM INT EXIT

    while true; do
      working=0
      # `agent list` fails (nonzero, stderr) when no herdr server is running;
      # that safely resolves to "no agents working".
      if list=$("$herdr" agent list 2>/dev/null); then
        count=$(printf '%s' "$list" \
          | "$jq" -r '[.result.agents[]? | select(.agent_status == "working")] | length' 2>/dev/null \
          || printf '0')
        [ "''${count:-0}" -gt 0 ] && working=1
      fi

      if [ "$working" -eq 1 ]; then
        if [ -z "$caff_pid" ] || ! kill -0 "$caff_pid" 2>/dev/null; then
          # -s prevents system sleep (AC), -i prevents idle sleep (also on battery)
          "$caffeinate" -s -i &
          caff_pid=$!
        fi
      else
        stop_caffeinate
      fi

      sleep ${toString interval}
    done
  '';
in
{
  launchd.user.agents.herdr-caffeinate = {
    serviceConfig = {
      ProgramArguments = [ "${supervisor}" ];
      RunAtLoad = true;
      KeepAlive = true;
      ProcessType = "Background";
      StandardErrorPath = "/tmp/herdr-caffeinate.err.log";
    };
  };
}
