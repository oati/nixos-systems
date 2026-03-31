# nixos-systems

NixOS configurations for my personal use.

## Architecture

### Nix

- `flake.nix` defines flake inputs and outputs. It generates outputs solely based on the systems defined in `systems.nix`

- `systems.nix` is a nix attribute set defining a list of NixOS modules to import for each system.

### Base Modules

- `modules/core` configures options that should be present on every system that I want to use.

- `modules/identity` configures options that should be set uniquely for each instance of a configuration.

- `modules/hardware` configures options specific to the hardware used by a system.

- `modules/filesystems` configures filesystem organization and mounting.

### Programs and Features

- `modules/role` configures options specific to the role or purpose of the system.

- `modules/security` configures programs related to system security.

- `modules/desktop` configures options for specific desktop environments.

- `modules/devtools` configures programs that assist in programming and development (including nix development).

- `modules/extra` configures nonessential programs that have a niche or specialized purpose.

## Design Principles

- The codebase should take as little effort as possible to understand.  
  The behavior and effect of a component should be clear from its own code when possible, and documented when unclear.
  Any dependencies between components should be explicit and easy to understand.

- Components should be associated with semantic units of functionality.
  Code associated with the same functionality should be close to each other and isolated from other code.

- Explanations should be provided with code whose purpose is not clear, non-obvious implementation decisions, and any technical workarounds.

- Imperative steps should be documented.  
  (See `install.txt` and `**/setup*.txt`)
