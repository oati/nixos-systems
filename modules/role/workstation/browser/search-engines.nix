{user, ...}: {
  home-manager.users.${user} = {
    programs.librewolf = {
      # https://mozilla.github.io/policy-templates/
      policies = {
        SearchEngines = {
          PreventInstalls = true;

          # default search engine
          Default = "Google Web";

          Add = [
            {
              Name = "Google Web";
              URLTemplate = "https://google.com/search?hl=en&pws=0&udm=14&q={searchTerms}";
              Method = "GET";
            }
          ];

          # remove built in search engines
          Remove = [
            "Bing"
            "DuckDuckGo"
            "DuckDuckGo Lite"
            "Google"
            "MetaGer"
            "Mojeek"
            "Perplexity"
            "Searx Belgium"
            "Startpage"
            "Wikipedia (en)"
          ];
        };
      };

      profiles.default = {
        search = {
          force = true;

          order = [
            "policy-Google Web"
            "wikipedia-en"
            "wiktionary"
            "google-scholar"
            "wolfram-alpha"
            "youtube"
            "nixpkgs"
            "home-manager"
          ];

          engines = {
            "policy-Google Web" = {
              metaData.alias = "g";
            };

            wikipedia-en = {
              name = "Wikipedia";
              urls = [{template = "https://en.wikipedia.org/wiki/Special:Search/{searchTerms}";}];
              iconMapObj."48" = "https://en.wikipedia.org/favicon.ico";
              definedAliases = ["w"];
            };

            wiktionary = {
              name = "Wiktionary";
              urls = [{template = "https://en.wiktionary.org/wiki/Special:Search/{searchTerms}";}];
              iconMapObj."48" = "https://en.wiktionary.org/favicon.ico";
              definedAliases = ["wk"];
            };

            google-scholar = {
              name = "Google Scholar";
              urls = [{template = "https://scholar.google.com/scholar?q={searchTerms}";}];
              iconMapObj."48" = "https://scholar.google.com/favicon.ico";
              definedAliases = ["gs"];
            };

            wolfram-alpha = {
              name = "Wolfram Alpha";
              urls = [{template = "https://wolframalpha.com/input?i={searchTerms}";}];
              iconMapObj."48" = "https://wolfram.com/favicon.ico";
              definedAliases = ["wa"];
            };

            youtube = {
              name = "Youtube";
              urls = [{template = "https://youtube.com/results?search_query={searchTerms}";}];
              iconMapObj."16" = "https://youtube.com/favicon.ico";
              definedAliases = ["yt"];
            };

            nixpkgs = {
              name = "Nixpkgs";
              urls = [{template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";}];
              iconMapObj."64" = "https://nixos.org/favicon.ico";
              definedAliases = ["np"];
            };

            home-manager = {
              name = "Home Manager";
              urls = [{template = "https://home-manager-options.extranix.com/?release=master&query={searchTerms}";}];
              iconMapObj."64" = "https://nixos.org/favicon.ico";
              definedAliases = ["hm"];
            };
          };
        };
      };
    };
  };
}
