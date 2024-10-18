## Getting started

### 1. Install [`Nix`](https://nixos.org)

```bash
$ sh <(curl -L https://nixos.org/nix/install)
```

### 2. Install [`nix-darwin`](https://github.com/LnL7/nix-darwin) and apply configuration

```bash
$ nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .
```

## Commands

### Update configuration
```bash
$ darwin-rebuild switch --flake .
```

### Upgrade packages
```bash
$ nix flake update
```