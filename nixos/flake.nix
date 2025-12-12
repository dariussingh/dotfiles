{
  description = "My NixOS Configuration (System and User)";

  # Define all dependencies (inputs)
  inputs = {
    # 1. Main NixOS/Nixpkgs channel
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # stable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # unstable

    # 2. Home Manager
    # home-manager.url = "github:nix-community/home-manager/release-25.05"; # stable
    home-manager.url = "github:nix-community/home-manager/master"; # unstable
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; 
    
    # 3. Add devenv 🚀
    devenv.url = "github:cachix/devenv";

    # 4. AI tools
    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  # Define what the flake produces (outputs)
  outputs = { self, nixpkgs, home-manager, devenv, llm-agents, ... }: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # IMPORTANT: Adjust for your architecture if not x86_64
      
      modules = [
        # Pass home-manager to the main configuration file
        { 
          imports = [
            ./configuration.nix
          ];
        }
        
        # Add devenv package
        ({ pkgs, ... }: {
          environment.systemPackages = [
            devenv.packages.${pkgs.system}.default
          ];
        })
      ];
      
      # Explicitly pass the home-manager input to the configuration file
      specialArgs = {
        inherit home-manager llm-agents;
      };
    };
  };
}
