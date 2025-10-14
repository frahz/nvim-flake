{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    mnw.url = "github:Gerg-L/mnw";
  };
  outputs =
    {
      nixpkgs,
      mnw,
      self,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems =
        function: nixpkgs.lib.genAttrs systems (system: function nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: rec {
        default = mnw.lib.wrap pkgs {
          neovim = pkgs.neovim-unwrapped;

          # all files in the `lua/lazy` folder are now autoloaded, so no need
          # for an init.lua in there
          initLua = ''
            require("frahz")
            LZN = require("lz.n")
            LZN.load("lazy")
          '';

          plugins = {
            start = mnw.lib.npinsToPlugins pkgs ./npins/start.json;

            # Anything that you're loading lazily should be put here
            opt = [
              pkgs.vimPlugins.blink-cmp
              pkgs.vimPlugins.nvim-treesitter.withAllGrammars
            ] ++ mnw.lib.npinsToPlugins pkgs ./npins/opt.json;

            dev.frahz = {
              pure = ./.;
              impure = "~/coding/neovim-flake";
            };
          };
          extraBinPath = [
            pkgs.fd
            pkgs.fzf
            pkgs.git
            pkgs.ripgrep

            pkgs.nil
            pkgs.tinymist
            pkgs.marksman

            # Formatters
            pkgs.typstyle
            pkgs.nixfmt-rfc-style
          ];
        };

        dev = default.devMode;
      });
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = [
            self.packages.${pkgs.system}.dev
            pkgs.npins
          ];
        };
      });
    };
}
