{
  description = "Nix for macOS configuration";

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    homebrew-services = {
      url = "github:homebrew/homebrew-services";
      flake = false;
    };

    homebrew-bun = {
      url = "github:oven-sh/homebrew-bun";
      flake = false;
    };

    nix-vscode-extensions = {
      # TODO: switch back to nix-community repo when their PR is merged
      # url = "github:nix-community/nix-vscode-extensions";
      url = "github:dseum/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin-custom-icons.url = "github:ryanccn/nix-darwin-custom-icons";

    opnix.url = "github:brizzbuzz/opnix";
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    homebrew-bundle,
    homebrew-services,
    homebrew-bun,
    darwin-custom-icons,
    opnix,
    ...
  }: let
    userfullname = "Benjamin Janssens";
    useremail = "benji.janssens@gmail.com";

    machines = {
      "MacBook-Pro-van-benji" = {
        profile = "personal";
        system = "aarch64-darwin";
        username = "benji";
      };
      "BEP6NDVF74Q5" = {
        profile = "work";
        system = "aarch64-darwin";
        username = "bejanssens";
      };
      "test" = {
        profile = "test";
        system = "aarch64-darwin";
        username = "test";
      };
    };

    mkSpecialArgs = hostname: machine:
      inputs
      // {
        inherit userfullname useremail hostname;
        inherit (machine) username;
        profile = machine.profile;
      };
  in {
    darwinConfigurations =
      builtins.mapAttrs (
        hostname: machine:
          darwin.lib.darwinSystem {
            inherit (machine) system;
            specialArgs = mkSpecialArgs hostname machine;
            modules = [
              ./modules/nix-core.nix
              ./modules/system.nix
              ./modules/apps.nix
              ./modules/host-users.nix
              ./modules/icons

              # home manager
              home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = mkSpecialArgs hostname machine;
                home-manager.sharedModules = [opnix.homeManagerModules.default];
                home-manager.users.${machine.username} = import ./home;
              }

              nix-homebrew.darwinModules.nix-homebrew
              {
                nix-homebrew = {
                  # Install Homebrew under the default prefix
                  enable = true;

                  # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
                  enableRosetta = true;

                  # User owning the Homebrew prefix
                  user = machine.username;

                  taps = {
                    "homebrew/homebrew-core" = homebrew-core;
                    "homebrew/homebrew-cask" = homebrew-cask;
                    "homebrew/homebrew-bundle" = homebrew-bundle;
                    "homebrew/homebrew-services" = homebrew-services;
                    "oven-sh/homebrew-bun" = homebrew-bun;
                  };

                  # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
                  mutableTaps = false;
                };
              }

              darwin-custom-icons.darwinModules.default
            ];
          }
      )
      machines;

    # nix code formatter
    formatter =
      builtins.mapAttrs (
        _: machine: nixpkgs.legacyPackages.${machine.system}.alejandra
      )
      machines;
  };
}
