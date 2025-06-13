{
  description = "NixOS + Home Manager flake setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {


    nixosConfigurations."TheoNixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/TheoNixos.nix
	home-manager.nixosModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.users.dan = import ./home/dan.nix;
	}
      ];
    };
  };
}

