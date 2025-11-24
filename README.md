Wezterm Config
==============

This directory provides my [wezterm](https://wezterm.org/) config
files.

## Table of contents

- [What's wezterm?](#whats-wezterm)
- [Set up the config](#set-up-the-config)
- [Changes done](#changes-done)
  - [Fonts](#fonts)
    - [Ligatures](#ligatures)
  - [Color scheme](#color-scheme)
  - [Full screen on start up](#full-screen-on-start-up)

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
>
> - I Strongly recommend to place the cloned the repo at
>   `$HOME/.config/` on **Windows** or `~/.config/` at **UNIX**,
>   since wezterm can't access modules in _"C's unsafe mode"_.

## Changes done

### Fonts

I've set [Iosevka](https://typeof.net/Iosevka/) as my default font.
Instead of just using `wezterm.font` function, I've used
`font_with_fallback`, allowing to choose less prefered fonts if most
prefered isn't available.

My current font fallback _(11/24/25)_ is:
1. Iosevka Term _(DemiBold)_
2. Iosevka _(Bold)_
3. JetBrains Mono _(Bold)_
4. Terminus _(Bold)_
5. Noto Color Emoji
6. monospace

You can change it at `submodules/fonts.lua` files.

#### Ligatures

I've also turned the ligatures **off**. I don't like it at all,
But you can turn it **on** if you prefer!

The ligatures can be turned off by using the `harfbuzz_features`
field on the config table:

```lua
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
```

`harfbuzz` and it's features are mentioned at wezterm [font-shaping
config page](https://wezterm.org/config/font-shaping.html). You can
change this features at `submodules/fonts.lua` file:

```lua
local function push_into_font_table(font)
  if type(font) == "string" then
    font = {
      family = font,
      -- line 1 bellow
      harfbuzz_features = disabled_harfbuzz
    }
  elseif type(font) == "table" then
      -- line 2 bellow
    font.harfbuzz_features = disabled_harfbuzz
  else
    panic_on(
      true,
      "push_font_into_table: `font` param must be either `string` or `table`"
    )
  end
  font_table[#font_table + 1] = font
end
```

Since wezterm ligatures are enabled by default, you can just comment
the `line 1` and `line 2` mentioned above.

### Color scheme

I'm currently using the [galizur](https://wezterm.org/colorschemes/g/index.html#galizur)
colorscheme provided by the builtin wezterm.

The colorscheme setting is placed at `submodules/ui.lua` and is
intended to change:

```lua
local M = {}
local color_scheme = "Galizur"

-- ...

M.color_scheme = color_scheme
return M
```

### Full screen on start up

I've tests the full screen code sample feature provided by
[`@wez`](https://github.com/wez) _(wezterm author)_:

```lua
local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

return {}
```

He said that:

> Windows and Wayland nightly builds with this feature are currently
> building, but X11 and macOS builds already have it available.

On `Windows 10/11`, this enable the full screen on startup, but
doesn't hide the Windows task bar and doesn't allow window resizing.

So, I decided to comment this code, but you can uncomment and turn it
on at `wezterm.lua` file.

<!-- TODO: add keymap changes -->
