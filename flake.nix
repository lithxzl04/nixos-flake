{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    hermes-agent.url = "github:NousResearch/hermes-agent";
  };
  outputs = inputs: {
    packages = builtins.mapAttrs (system: pkgs: {
      hello = pkgs.hello;
      default = inputs.self.packages.${system}.hello;
    } // (if inputs.hermes-agent.packages ? ${system}
          then { hermes-agent = inputs.hermes-agent.packages.${system}.default; }
          else {})) inputs.nixpkgs.legacyPackages;

    nixosConfigurations."3301-nix" = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        {
          environment.systemPackages = [
            inputs.hermes-agent.packages.x86_64-linux.default
          ];
        }
      ];
    };
  };
}

