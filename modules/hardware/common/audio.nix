{ user, ... }:
let
  sampleRate = 96000;
  resampleQuality = 10; # 0-14; default 4

  # lower is lower latency
  quantum = 4; # ms
  defaultQuantum = 8 * 48; # samples
  maxQuantum = 2048; # samples
  tlength = 8; # ms - should be at least 2 * quantum
in
{
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;

    extraConfig = {
      pipewire."99-low-latency" = {
        "context.properties" = {
          # idle graph rate
          "default.clock.rate" = sampleRate; # default 48000
          # allowed graph rates
          "default.clock.allowed-rates" = [
            48000
            sampleRate
          ];

          # hints for alsa hardware quantum negotiation
          "default.clock.quantum" = defaultQuantum; # default 1024
          "default.clock.min-quantum" = defaultQuantum; # default 32
          "default.clock.max-quantum" = maxQuantum; # default 8192

          "clock.power-of-two-quantum" = false; # default true
        };
      };

      pipewire-pulse."99-low-latency" = {
        # force pulseaudio client behavior
        "pulse.properties" = {
          "pulse.min.req" = "${toString quantum}/1000"; # default 256/48000
          "pulse.default.req" = "${toString quantum}/1000"; # default 960/48000
          "pulse.min.quantum" = "${toString quantum}/1000"; # default 256/48000

          # server-side playback buffering
          "pulse.default.tlength" = "${toString tlength}/1000"; # default 2
        };

        "stream.properties" = {
          # default graph quantum hint
          "node.latency" = "${toString quantum}/1000";
        };
      };

      client."99-resample-quality" = {
        "stream.properties"."resample.quality" = resampleQuality;
      };

      pipewire-pulse."99-resample-quality" = {
        "stream.properties"."resample.quality" = resampleQuality;
      };
    };

    # device specific configs
    wireplumber.extraConfig."99-alsa-low-latency" = {
      "monitor.alsa.rules" = [
        {
          # pw-cli list-objects Node
          matches = [ { "node.name" = "~alsa_output.*Qudelix-5K*"; } ];
          actions."update-props" = {
            "audio.format" = "S24LE";
            "audio.rate" = sampleRate;
            "node.latency" = "${toString quantum}/1000";
          };
        }
      ];
    };
  };

  # realtime priority for pipewire
  security.rtkit.enable = true;

  home-manager.users.${user} = {
    home.sessionVariables = {
      # override latency for apps that support it
      PULSE_LATENCY_MSEC = quantum;
    };
  };
}
