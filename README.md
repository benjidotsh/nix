# Nix for macOS configuration

This is my personal Nix for macOS configuration.

## Prerequisites

<details>
<summary>Nix</summary>
<br>
<pre>
$ sh <(curl -L https://nixos.org/nix/install)
</pre>
</details>

<details>
<summary>Xcode Command Line Tools</summary>
<br>
<pre>
$ xcode-select --install
</pre>
</details>

<details>
<summary>Rosetta 2</summary>
<br>
<pre>
$ softwareupdate --install-rosetta
</pre>
</details>

## Getting started

### 1. Clone this repository

```bash
$ git clone git@github.com:benjidotsh/nix.git
```

### 2. Deploy the configuration

```bash
$ nix build .#darwinConfigurations.$(hostname -s).system --extra-experimental-features 'nix-command flakes'

$ sudo ./result/sw/bin/darwin-rebuild switch --flake .#$(hostname -s)
```

After deploying the configuration for the first time, you can simply run `just deploy` to apply changes.

To view all available commands, run `just`.

## Additional configuration

The following configuration can't be managed by Nix and needs to be configured manually:

- **Enable the 1Password SSH agent**
  1. Open 1Password → Settings → Developer.
  2. Enable “Use the SSH agent”.

- **Apply the custom Terminal theme**
  1. Open Terminal → Settings → Profiles.
  2. Import [catppuccin-macchiato.terminal](./misc/catppuccin-macchiato.terminal) and set it as default.

- **Disable Terminal prompt line markers**
  1. Navigate to Terminal → Edit → Marks.
  2. Disable “Automatically Mark Prompt Lines".
