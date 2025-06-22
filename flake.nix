{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    mnw.url = "github:Gerg-L/mnw";
  };
  outputs = {
    nixpkgs,
    mnw,
    self,
    ...
  }: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
    forEachSystem = nixpkgs.lib.genAttrs systems;
    pkgsForEach = forEachSystem (system:
      import nixpkgs {
        inherit system;
      });
  in {
    packages = forEachSystem(system: let
      pkgs = pkgsForEach.${system};
    in {
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
          start = [
            pkgs.vimPlugins.lz-n

            # theme
            pkgs.vimPlugins.catppuccin-nvim

            pkgs.vimPlugins.blink-cmp

            # LSP
            pkgs.vimPlugins.fidget-nvim
            pkgs.vimPlugins.nvim-lspconfig
            pkgs.vimPlugins.crates-nvim

            pkgs.vimPlugins.nvim-treesitter.withAllGrammars
            pkgs.vimPlugins.nvim-ts-context-commentstring

            # Telescope
            pkgs.vimPlugins.plenary-nvim
            pkgs.vimPlugins.telescope-fzf-native-nvim

            # Snippets
            pkgs.vimPlugins.luasnip
            pkgs.vimPlugins.friendly-snippets

            # Symbols Viewer
            pkgs.vimPlugins.aerial-nvim

            # Autopairs
            pkgs.vimPlugins.nvim-autopairs

            # Better comment keybinds
            pkgs.vimPlugins.comment-nvim

            # Indent guides
            pkgs.vimPlugins.indent-blankline-nvim

            # Detect indentation style
            pkgs.vimPlugins.guess-indent-nvim

            # Statusline
            pkgs.vimPlugins.nvim-web-devicons
            pkgs.vimPlugins.lualine-nvim

            # Git support
            pkgs.vimPlugins.gitsigns-nvim

            # Greeter
            pkgs.vimPlugins.alpha-nvim

            # Typst support
            pkgs.vimPlugins.typst-preview-nvim

            # File explorer
            pkgs.vimPlugins.oil-nvim

            # Misc
            pkgs.vimPlugins.lazydev-nvim
            pkgs.vimPlugins.rainbow-delimiters-nvim
          ];

          # Anything that you're loading lazily should be put here
          opt = [
            pkgs.vimPlugins.telescope-nvim
          ];

          dev.frahz = {
            pure = ./.;
            impure = "~/coding/neovim-flake";
          };
        };
        extraBinPath = [
          pkgs.ripgrep
          pkgs.fd
          pkgs.gcc
          pkgs.git

          # TODO: LSP
          pkgs.libclang
          pkgs.nil
          pkgs.nodePackages.bash-language-server
          pkgs.nodePackages.typescript-language-server
          pkgs.pyright
          pkgs.rust-analyzer
          pkgs.lua-language-server
          pkgs.gopls
          pkgs.vscode-langservers-extracted
          pkgs.htmx-lsp
          pkgs.tailwindcss-language-server
          pkgs.svelte-language-server
          pkgs.tinymist
          pkgs.marksman

          # Formatters
          pkgs.typstyle
        ];
      };

      dev = self.packages.x86_64-linux.default.devMode;
    });
    devShells = forEachSystem (system: let
      pkgs = pkgsForEach.${system};
    in {
      default = pkgs.mkShellNoCC {
        packages = [
          self.packages.${system}.default.devMode
        ];
      };
    });
  };
}
