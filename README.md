nix-shell -p wget --run "wget https://raw.githubusercontent.com/lvnilesh/nixos-config-venus/refs/heads/master/f.nix"

mkdir -p ~/nixos-config
mv f.nix ~/nixos-config/flake.nix

sudo nixos-rebuild switch --flake ~/nixos-config/#my-overrides --impure
