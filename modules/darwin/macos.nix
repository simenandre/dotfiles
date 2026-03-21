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
    };

    dock = {
      # Minimize windows into their application's icon
      minimize-to-application = true;
      # Show indicator lights for open applications in the Dock
      show-process-indicators = true;
      # Wipe all default app icons from the Dock
      persistent-apps = [ ];
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
