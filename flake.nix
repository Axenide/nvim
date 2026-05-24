{
  description = "Adriano's NvChad configuration ported to nix4nvchad";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nvchad-starter = {
      url = "path:./nvchad-starter";
      flake = false;
    };

    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nvchad-starter.follows = "nvchad-starter";
    };
  };

  outputs = { self, nixpkgs, nix4nvchad, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

      nvchadConfig = pkgs:
        let
          qmlls6Compat = pkgs.runCommand "qmlls6-compat" {} ''
            mkdir -p $out/bin
            ln -s ${pkgs.qt6.qtdeclarative}/bin/qmlls $out/bin/qmlls
            ln -s ${pkgs.qt6.qtdeclarative}/bin/qmlls $out/bin/qmlls6
          '';
        in
        {
        lazy-lock = builtins.readFile ./nvchad-starter/lazy-lock.json;
        extraPackages = with pkgs; [
          alejandra
          black
          gcc
          git
          gnumake
          imagemagick
          isort
          nodejs
          pkgs.python3Packages.debugpy
          prettier
          procps
          pyright
          qmlls6Compat
          shfmt
          stylua
          tree-sitter
          vscode-langservers-extracted
          yarn
        ];
      };
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = nix4nvchad.packages.${system}.default.override (nvchadConfig pkgs);
          nvchad = self.packages.${system}.default;
        });

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/nvim";
        };
      });

      homeManagerModules.default = { pkgs, ... }: {
        imports = [ nix4nvchad.homeManagerModules.default ];

        programs.nvchad = (nvchadConfig pkgs) // {
          enable = true;
        };
      };
    };
}
