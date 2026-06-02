{
  user,
  pkgs,
  ...
}:
{
  imports = [
    ./packages
  ];

  home-manager.users.${user} =
    { lib, ... }:
    {
      home.packages = [
        pkgs.katago
        pkgs.sabaki
      ];

      home.activation = {
        setSabakiSettings =
          let
            # https://katagotraining.org/networks/
            katago-network = pkgs.fetchurl {
              url = "https://media.katagotraining.org/uploaded/networks/models/kata1/kata1-zhizi-b40c768nbt-fdx6d.bin.gz";
              hash = "sha256-DPlYcAi2z7Fb/R3KBIQaif8wQpINpFK1hdQmpNoYuoM=";
            };

            # https://katagotraining.org/extra_networks/
            katago-human-network = pkgs.fetchurl {
              url = "https://media.katagotraining.org/uploaded/networks/models_extra/b18c384nbt-humanv0.bin.gz";
              hash = "sha256-Y3dG5E8O/gCtEkWlCqm78HFu/jZMQ5ZerZe9aDXYSrU=";
            };

            katago-config = {
              rules = "tromp-taylor";

              logAllGTPCommunication = false;
              logSearchInfo = false;

              # analysis
              reportAnalysisWinratesAs = "SIDETOMOVE";
              analysisIgnorePreRootHistory = true;
              analysisWideRootNoise = 0.1;

              # tune with katago benchmark
              numSearchThreads = 5;

              nnCacheSizePowerOfTwo = 22;
              nnMutexPoolSizePowerOfTwo = 17;
            };

            # https://github.com/lightvector/KataGo/blob/master/cpp/configs/gtp_human5k_example.cfg
            katago-human-config = rank: {
              rules = "tromp-taylor";

              logAllGTPCommunication = false;
              logSearchInfo = false;

              # rank 20k to 9d
              humanSLProfile = "rank_${rank}";
              humanSLChosenMoveProp = 1.0;
              humanSLChosenMoveIgnorePass = false;
              humanSLChosenMovePiklLambda = 100000000;

              chosenMoveTemperatureEarly = 0.85;
              chosenMoveTemperature = 0.70;
              chosenMoveTemperatureHalflife = 80;
              # temperature only starts to dampen moves below this
              chosenMoveTemperatureOnlyBelowProb = 0.01;
              chosenMoveSubtract = 0;
              chosenMovePrune = 0;

              allowResignation = "true";
              resignThreshold = -0.99;
              resignConsecTurns = 20;
              resignMinScoreDifference = 40;
              resignMinMovesPerBoardArea = 0.4;
              maxVisits = 40;
              numSearchThreads = 1;

              delayMoveScale = 2.0;
              delayMoveMax = 10.0;

              ignorePreRootHistory = false;
              analysisIgnorePreRootHistory = false;
              rootNumSymmetriesToSample = 2;
              useLcbForSelection = false;
              winLossUtilityFactor = 1.0;
              staticScoreUtilityFactor = 0.30;
              dynamicScoreUtilityFactor = 0.00;
              useUncertainty = false;
              subtreeValueBiasFactor = 0.0;
              useNoisePruning = false;

              nnCacheSizePowerOfTwo = 17;
              nnMutexPoolSizePowerOfTwo = 14;
            };

            writeConfig =
              pname: conf:
              pkgs.writeText pname (
                lib.concatStringsSep "\n" (lib.mapAttrsToList (name: value: "${name} = ${lib.toJSON value}") conf)
              );

            settings = {
              "app.enable_hardware_acceleration" = true;
              "app.startup_check_updates" = false;

              "board.analysis_type" = "scoreLead";

              "engines.list" = [
                {
                  name = "KataGo";
                  path = lib.getExe pkgs.katago;
                  args = lib.concatStringsSep " " [
                    "gtp"
                    "-model ${katago-network}"
                    "-config ${writeConfig "katago-config" katago-config}"
                  ];
                }
              ]
              ++ (
                let
                  katagoHumanStyle = rank: {
                    name = "KataGo Human-style ${rank}";
                    path = lib.getExe pkgs.katago;
                    args = lib.concatStringsSep " " [
                      "gtp"
                      "-model ${katago-network}"
                      "-human-model ${katago-human-network}"
                      "-config ${writeConfig "katago-human-${rank}-config" (katago-human-config rank)}"
                    ];
                  };
                in
                map katagoHumanStyle
                  # katago human-style play ranks
                  [
                    "15k"
                    "10k"
                    "5k"
                    "1d"
                  ]
              );
            };
          in
          lib.hm.dag.entryAfter [ "writeBoundary" ]
            # sh
            ''
              run mkdir -p $VERBOSE_ARG ~/.config/Sabaki
              run cp $VERBOSE_ARG \
                --remove-destination \
                --no-preserve=mode \
                ${pkgs.writers.writeJSON "sabaki-settings" settings} \
                ~/.config/Sabaki/settings.json
            '';
      };
    };

  intransience.datastores.cache.users.${user}.dirs = [
    ".katago"
  ];
}
