{ config, ... }:

{
  home.file.".config/twm/twm.yaml".text = ''
    search_paths:
      - ${config.home.homeDirectory}/ghq
      - ~/.config/nvim/

    exclude_path_components:
      - .git
      - .direnv
      - node_modules
      - venv
      - target

    workspace_definitions:
      - name: catchall
        default_layout: catchall-dev

      - name: go
        has_all_files:
          - go.mod
          - go.sum

      - name: docker-compose
        has_any_file:
          - docker-compose.yml
          - docker-compose.yaml
        has_all_files:
          - Dockerfile
          - .git

      - name: pulumi
        has_all_files:
          - Pulumi.yaml
  '';
}
