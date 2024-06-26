# /etc/nixos/flake.nix
{
  inputs = {
    # NOTE: Replace "nixos-24.05" with that which is in system.stateVersion of
    # configuration.nix. You can also use latter versions if you wish to
    # upgrade.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    # NOTE: 'nixos' is the default hostname set by the installer
    nixosConfigurations.venus = nixpkgs.lib.nixosSystem {
      # NOTE: Change this to aarch64-linux if you are on ARM
      system = "x86_64-linux";
      modules = [
        ./configuration.nix 
        {
          nix = {
            settings.experimental-features = [ "nix-command" "flakes" ];
          };
        }
      ];
    };
  };
}
