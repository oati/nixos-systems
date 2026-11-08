{ user, ... }:
let
  # default pipewire graph rate
  sampleRate = 96000;

  # pipewire resampler quality; 0-14, default 4
  # higher values use longer filters for better quality at the cost of CPU and latency
  resampleQuality = 10;

  latency = rec {
    # pipewire graph cycle length
    ms = 4;

    # longest cycle the graph may stretch to.
    # this ceiling only matters when streams ask for larger buffers.
    maxMs = 20;

    # how many cycles of audio pipewire-pulse buffers server-side
    # for each PulseAudio playback stream (tlength).
    # more gives clients headroom against underruns but adds playback latency.
    # should be at least 2: one cycle playing while the next is written.
    periods = 2;

    # derived values

    samples = ms * sampleRate / 1000;
    maxSamples = maxMs * sampleRate / 1000;

    frac = "${toString ms}/1000";
    tlengthFrac = "${toString (periods * ms)}/1000";
  };
in
{
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };

    extraConfig = {
      # pipewire daemon
      pipewire."99-low-latency" = {
        "context.properties" = {
          # default pipewire graph rate.
          # default.clock.*quantum sample counts are relative to this rate
          # and get scaled when the graph switches rates.
          "default.clock.rate" = sampleRate; # default 48000
          # rates the graph may switch to while devices are idle
          "default.clock.allowed-rates" = [
            48000
            44100
            sampleRate
          ];

          # quantum used when no client specifies one
          "default.clock.quantum" = latency.samples; # default 1024
          # quantum floor
          "default.clock.min-quantum" = latency.samples; # default 32
          # quantum ceiling
          "default.clock.max-quantum" = latency.maxSamples; # default 8192

          # when true, client requests and the graph quantum are rounded down to a power of two
          "clock.power-of-two-quantum" = false; # default true
        };
      };

      # pulseaudio-protocol server for libpulse clients
      pipewire-pulse."99-low-latency" = {
        "pulse.properties" = {
          # server request size for clients that don't specify one
          "pulse.default.req" = latency.frac; # default 960/48000
          # request size floor
          "pulse.min.req" = latency.frac; # default 256/48000
          # floor on the graph quantum derived from a pulse client's req/tlength
          "pulse.min.quantum" = latency.frac; # default 256/48000
          # server-side buffer target for clients that don't specify one
          "pulse.default.tlength" = latency.tlengthFrac; # default 96000/48000
        };

        # suggested latency for pulse client streams
        "stream.properties"."node.latency" = latency.frac;
      };

      # resample quality for native pipewire clients and apps using pipewire's ALSA plugin
      client."99-resample-quality" = {
        "stream.properties"."resample.quality" = resampleQuality;
      };

      # resample quality for pulse clients
      pipewire-pulse."99-resample-quality" = {
        "stream.properties"."resample.quality" = resampleQuality;
      };
    };

    # per-device properties applied when ALSA nodes are created
    wireplumber.extraConfig."99-alsa-low-latency" = {
      "monitor.alsa.rules" = [
        {
          # find node names:
          # ~> pw-cli list-objects Node
          matches = [ { "node.name" = "~alsa_output.*Qudelix-5K*"; } ];
          actions."update-props" = {
            # open the DAC in 24-bit instead of the best format it offers
            "audio.format" = "S24LE";
            # suggested latency for the device node, so that
            # the sink also asks the graph for the same cycle length.
            # note: the graph uses the smallest suggestion.
            "node.latency" = latency.frac;
          };
        }
      ];
    };
  };

  # lets pipewire request realtime scheduling, so that
  # short cycles don't get preempted by other processes
  security.rtkit.enable = true;

  home-manager.users.${user} = {
    home.sessionVariables = {
      # buffering latency for libpulse in client apps
      # (no effect on the pipewire-pulse server itself)
      PULSE_LATENCY_MSEC = latency.ms;
    };
  };
}
