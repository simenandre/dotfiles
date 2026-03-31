{
  description = "Simen Andre's dotfiles configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    config-nvim = {
      url = "github:simenandre/config.nvim";
      flake = false;
    };

    dina = {
      url = "github:dinacomputer/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      config-nvim,
      dina,
    }:
    let
      mkHomeModules = username: [
        ./modules/home
        {
          home.username = username;
          home.file.".config/nvim".source = config-nvim;
        }
      ];
    in
    {
      darwinConfigurations."default" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./modules/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.extraSpecialArgs = { inherit dina; };
            home-manager.users.cobraz = { imports = mkHomeModules "cobraz"; };
          }
        ];
      };

      nixosConfigurations."nixbox" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixbox/hardware-configuration.nix
          ./modules/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.extraSpecialArgs = { inherit dina; };
            home-manager.users.simenandre = { imports = mkHomeModules "simenandre"; };
          }
        ];
      };

      homeConfigurations."simenandre" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit dina; };
        modules = mkHomeModules "simenandre";
      };

      homeConfigurations."simenandre@aarch64-linux" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
        extraSpecialArgs = { inherit dina; };
        modules = mkHomeModules "simenandre";
      };
    };
}
