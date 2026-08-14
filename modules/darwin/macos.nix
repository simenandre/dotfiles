{ ... }:

{
  system.defaults = {
    NSGlobalDomain = {
      # Sidebar icon size: medium
      NSTableViewDefaultSizeMode = 2;
      # Always show scrollbars
      AppleShowScrollBars = "Always";
      # Expand save panel by default
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      # Expand print panel by default
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
      # Save to disk (not to iCloud) by default
      NSDocumentSaveNewDocumentsToCloud = false;
      # Disable auto-correct
      NSAutomaticSpellingCorrectionEnabled = false;
      # Font smoothing
      AppleFontSmoothing = 1;
      # Dark appearance
      AppleInterfaceStyle = "Dark";
      # Show all file extensions
      AppleShowAllExtensions = true;
      # Disable two-finger swipe for back/forward navigation
      AppleEnableSwipeNavigateWithScrolls = false;
      # Tap to click, also honoured by the login screen
      "com.apple.mouse.tapBehavior" = 1;
      # Faster key repeat than the System Settings sliders allow
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
    };

    dock = {
      # Minimize windows into their application's icon
      minimize-to-application = true;
      # Show indicator lights for open applications in the Dock
      show-process-indicators = true;
      # Wipe all default app icons from the Dock
      persistent-apps = [ ];
      # Wipe the default Downloads stack from the Dock
      persistent-others = [ ];
      # Smaller Dock icons
      tilesize = 34;
      # Disable the pinch-to-Launchpad gesture
      showLaunchpadGestureEnabled = false;
      # Speed up Mission Control animations
      expose-animation-duration = 0.1;
      # Remove the auto-hiding Dock delay
      autohide-delay = 0.0;
      # Remove the animation when hiding/showing the Dock
      autohide-time-modifier = 0.0;
      # Automatically hide and show the Dock
      autohide = true;
      # Make Dock icons of hidden applications translucent
      showhidden = true;
      # Don't show recent applications in Dock
      show-recents = false;
    };

    finder = {
      # Show status bar
      ShowStatusBar = true;
      # Show path bar
      ShowPathbar = true;
      # Search the current folder by default
      FXDefaultSearchScope = "SCcf";
      # Disable warning when changing a file extension
      FXEnableExtensionChangeWarning = false;
      # Default to list view
      FXPreferredViewStyle = "Nlsv";
      # Remove items from the Trash after 30 days
      FXRemoveOldTrashItems = true;
    };

    screencapture = {
      # Save screenshots to ~/Screenshots
      location = "~/Screenshots";
      # Save screenshots as JPG
      type = "jpg";
    };

    trackpad = {
      # Enable tap to click for this user and the login screen
      Clicking = true;
      # Drag windows with three fingers
      TrackpadThreeFingerDrag = true;
      # Three-finger drag needs the three-finger swipe gestures out of the way
      TrackpadThreeFingerHorizSwipeGesture = 0;
      TrackpadThreeFingerVertSwipeGesture = 0;
    };


    ActivityMonitor = {
      # Show the main window when launching Activity Monitor
      OpenMainWindow = true;
      # Visualize CPU usage in the Activity Monitor Dock icon
      IconType = 5;
      # Show all processes in Activity Monitor
      ShowCategory = 100;
      # Sort Activity Monitor results by CPU usage
      SortColumn = "CPUUsage";
      SortDirection = 0;
    };

    LaunchServices = {
      # Disable the "Are you sure you want to open this application?" dialog
      LSQuarantine = false;
    };

    CustomUserPreferences = {
      NSGlobalDomain = {
        # Text replacements. Declared here, so System Settings edits are
        # overwritten on the next rebuild — add new snippets in this list.
        NSUserDictionaryReplacementItems = [
          {
            on = 1;
            replace = "ttt";
            "with" = "Ting tar tid";
          }
          {
            on = 1;
            replace = "ept";
            "with" = "Er på toget!";
          }
          {
            on = 1;
            replace = "ott";
            "with" = "On the train!";
          }
          {
            on = 1;
            replace = "epv";
            "with" = "Er på vei!";
          }
          {
            on = 1;
            replace = "omw";
            "with" = "On my way!";
          }
        ];
      };
      "com.apple.Siri" = {
        StatusMenuVisible = false;
        VoiceTriggerUserEnabled = false;
      };
      "com.apple.assistant.support" = {
        "Assistant Enabled" = false;
      };
      "com.apple.TextInputMenu" = {
        # Hide the input source menu bar icon
        visible = false;
      };
      "com.apple.controlcenter" = {
        # Hide the Shortcuts menu bar icon
        "NSStatusItem Visible Shortcuts" = false;
      };
      "com.apple.print.PrintingPrefs" = {
        # Automatically quit printer app once the print jobs complete
        "Quit When Finished" = true;
      };
      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.Safari" = {
        # Privacy: don't send search queries to Apple
        UniversalSearchEnabled = false;
        SuppressSearchSuggestions = true;
      };
      "com.apple.TimeMachine" = {
        # Prevent Time Machine from prompting to use new hard drives
        DoNotOfferNewDisksForBackup = true;
      };
      "com.apple.TextEdit" = {
        PlainTextEncoding = 4;
        PlainTextEncodingForWrite = 4;
      };
      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        ScheduleFrequency = 1;
        AutomaticDownload = 1;
        CriticalUpdateInstall = 1;
      };
      "com.apple.commerce" = {
        AutoUpdate = true;
        AutoUpdateRestartRequired = true;
      };
      "com.apple.helpviewer" = {
        DevMode = true;
      };
      "com.apple.BluetoothAudioAgent" = {
        "Apple Bitpool Min (editable)" = 40;
      };
      "com.google.Chrome" = {
        # Disable the all too sensitive backswipe on trackpads and Magic Mouse
        AppleEnableSwipeNavigateWithScrolls = false;
        AppleEnableMouseSwipeNavigateWithScrolls = false;
        # Expand the print dialog by default
        PMPrintingExpandedStateForPrint2 = true;
      };
      "com.apple.messageshelper.MessageController" = {
        SOInputLineSettings = {
          automaticQuoteSubstitutionEnabled = false;
          continuousSpellCheckingEnabled = false;
        };
      };
    };
  };
}
