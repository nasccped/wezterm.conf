Wezterm Config
==============

This directory provides my [wezterm](https://wezterm.org/) config
files.

## What's wezterm?

Wezterm is a cross-plataform terminal emulator written in
[Rust](https://rust-lang.org/).

It provides cool features such as:

- pane/tabs/windows multiplexing
- font fallback (nerd, emoji, ligatures)
- native mouse/scrollback

## Set up the config

1. Clone the repository:

```sh
git clone https://github.com/nasccped/wezterm.conf wezterm
```

2. Add the `$WEZTERM_CONFIG_FILE` env. var:

The wezterm will load the `lua` config file passed through the
`--config-file` flag argument. When no argument is provided, the
wezterm loads the `$WEZTERM_CONFIG_FILE` file path. You can
add/update this var on **Windows Sysenv. Variables**.

If you're at _UNIX_ system and the `$WEZTERM_CONFIG_FILE` isn't set,
you can place the cloned repo at `~/.config/wezterm` (will works the
same).

> [!IMPORTANT]
>
> - When setting the `$WEZTERM_CONFIG_FILE`, the expected path is the
>   `wezterm.lua` within the directory and not the directory itself
>   (ie. use `path/example/wezterm/wezterm.lua` instead of
>   `path/example/wezterm`).
>
> - Note that this will only works with some requirements:
>   - git
>   - wezterm
