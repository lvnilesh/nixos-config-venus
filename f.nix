{
  description = "my overrides";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.my-overrides = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ({config, ...}: {
					imports =
					[ # Include the results of the hardware scan.
						/etc/nixos/hardware-configuration.nix
					];

          # Complete override: No import of /etc/nixos/configuration.nix

					# Bootloader.
					boot.loader.grub.enable = true;
					boot.loader.grub.device = "/dev/sda";
					boot.loader.grub.useOSProber = false;

          services.displayManager.autoLogin = {
            enable = true;
            user = "cloudgenius";
          };

				  system.stateVersion = "24.11"; # Did you read the comment?

					# Define a user account. Don't forget to set a password with ‘passwd’.
					users.users.cloudgenius = {
						isNormalUser = true;
						description = "Nilesh";
						extraGroups = [ "networkmanager" "wheel" ];
					};

          services.openssh.enable = true;
          services.openssh.settings.PasswordAuthentication = true;
          services.openssh.settings.PermitRootLogin = "yes";
          services.pulseaudio.enable = false;
          environment.systemPackages = with nixpkgs.legacyPackages.${system}; [
            htop
            git
            vim
          ];
        })
      ];
    };
  };
}
