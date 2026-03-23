{
  flakes,
  user,
  pkgs,
  ...
}: {
  home-manager.users.${user} = {
    programs.vesktop = {
      enable = true;

      package = pkgs.vesktop.override {
        withMiddleClickScroll = true;
        withSystemVencord = true;
      };

      # https://github.com/Vencord/Vesktop/blob/main/src/shared/settings.d.ts
      settings = {
        discordBranch = "stable";
        arRPC = true;
        enableSplashScreen = false;
        hardwareAcceleration = true;
        hardwareVideoAcceleration = true;
        clickTrayToShowHide = true;
        disableMinSize = true;
        customTitleBar = true;
      };

      vencord = {
        settings = {
          autoUpdate = false;
          autoUpdateNotifications = false;
          useQuickCss = true;
          disableMinSize = true;

          plugins = {
            # discord features
            FakeNitro.enabled = true;
            Experiments.enabled = true;
            BetterSessions.enabled = true;

            # quality of life
            CustomIdle = {
              enabled = true;
              idleTimeout = 10;
              remainInIdle = false;
            };

            AlwaysTrust.enabled = true;
            CleanURLs.enabled = true;
            FixImagesQuality.enabled = true;

            BlurNSFW.enabled = true;
            HideMedia.enabled = true;
            NoUnblockToJump.enabled = true;

            PinDMs.enabled = true;
            CallTimer.enabled = true;
            MessageLinkEmbeds.enabled = true;
            ImageFilename.enabled = true;
            ImageLink.enabled = true;
            CopyFileContents.enabled = true;

            PictureInPicture = {
              enabled = true;
              loop = false;
            };
            YoutubeAdblock.enabled = true;
            FixYoutubeEmbeds.enabled = true;

            FullUserInChatbox.enabled = true;
            FullSearchContext.enabled = true;
            ValidReply.enabled = true;
            ValidUser.enabled = true;

            VoiceChatDoubleClick.enabled = true;

            # sending messages
            PreviewMessage.enabled = true;
            SendTimestamps.enabled = true;
            VoiceMessages.enabled = true;

            GifPaste.enabled = true;
            StickerPaste.enabled = true;
            GreetStickerPicker.enabled = true;

            # message info
            ReplyTimestamp.enabled = true;
            ViewRaw.enabled = true;
            VoiceDownload.enabled = true;

            # user info
            FixOwnerCrown.enabled = true;
            FriendsSince.enabled = true;
            MutualGroupDMs.enabled = true;
            PlatformIndicators.enabled = true;
            ViewIcons = {
              enabled = true;
              format = "png";
              imgSize = "4096";
            };
            TypingIndicator.enabled = true;
            TypingTweaks.enabled = true;
            UserVoiceShow.enabled = true;
            MentionAvatars.enabled = true;
            RelationshipNotifier.enabled = true;

            # server info
            ServerInfo.enabled = true;
            MemberCount.enabled = true;
            ShowHiddenChannels.enabled = true;
            ShowHiddenThings.enabled = true;
            PermissionsViewer.enabled = true;

            # moderating servers
            ExpressionCloner.enabled = true;
            PauseInvitesForever.enabled = true;
          };

          enabledThemes = [
            "default-fonts.css"
            "smaller-sidebar.css"
            "amoled-cord.css"
          ];
        };

        themes = {
          default-fonts =
            # css
            ''
              :root {
                --font-primary: "sans-serif";
                --font-display: "sans-serif";
                --font-code: "monospace";
              }
            '';

          # shrink sidebar from 240px if width is less than 2/3 of 1920px screen width
          smaller-sidebar =
            # css
            ''
              @media (max-width: 1280) {
                div [class *= "sidebarList__"] {
                  width: 210px !important;
                }
              }
            '';

          amoled-cord = "${flakes.amoled-cord}/clients/amoled-cord.theme.css";
        };
      };
    };
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".config/vesktop"
  ];
}
