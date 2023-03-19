# Sigma.nvim

![dashboard](https://imgur.com/B6j6H4B.png) ![fzf](https://imgur.com/4G1QokS.png)
![split](https://imgur.com/9fyyv3n.png) ![lazygit pane](https://imgur.com/ClilEoh.png)

<!--toc:start-->
- [Sigma.nvim](#sigmanvim)
  - [Why another Vim distribution](#why-another-vim-distribution)
  - [What is Sigma.nvim](#what-is-sigmanvim)
  - [Dependencies](#dependencies)
  - [Installation](#installation)
  - [Configuration](#configuration)
    - [FZF](#fzf)
    - [nnn](#nnn)
    - [lazygit](#lazygit)
    - [Overriding configuration](#overriding-configuration)
    - [Plugins](#plugins)
      - [Configuring plugins](#configuring-plugins)
      - [Configuring an LSP server](#configuring-an-lsp-server)
  - [Updating Sigma.nvim](#updating-sigmanvim)
  - [Features](#features)
  - [Known issues](#known-issues)
    - [Cursor line gets lost](#cursor-line-gets-lost)
    - [After first run / change in plugins config is not loaded](#after-first-run-change-in-plugins-config-is-not-loaded)
<!--toc:end-->

You might have already seen NvChad, but you want a simpler config and be a Chad
too? Sigma.vim was made for you.

## Why another Vim distribution

Most of these distributions are pretty complex, and usually happen to be a pain
to actually replace some base plugins. Sigma.nvim aims to be simple.

## What is Sigma.nvim

Sigma.nvim is [SigmaVimRc for Neovim](https://github.com/voidekh/SigmaVimRc#what-is-sigma).

Most of the points in its README apply here as well. It's pure Lua, only a bit
complicated part here is the LSP configuration, but you cannot do much about it.
And Sigma makes it actually simple for the user.

The main difference between Sigma.nvim and NvChad or AstroNvim is that there's
no Telescope. We use Fzf here, which provides all the features Telescope has,
and is not just a plugin. It's a tool you can use outside of your editor.

The same goes for Nnn as file picker, and Lazygit integration (which is a
big word for a single line of code).

The most opinionated part here is lack of file-tree plugin, which you can easily
add if you really want one. If you want Telescope, then I'm afraid there's no
point in ripping out Fzf and configuring Telescope in its place, even though it's
possible, but not really viable. In that case you might consider NvChad or AstroNvim.
Or LunarVim. Or Lazy.nvim. Or just mix and match and make your own config out of it. :)

## Dependencies

- [NerdFont](https://github.com/ryanoasis/nerd-fonts)
- [Fzf](https://github.com/junegunn/fzf) (All the fuzzy finding)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (For Fzf default
    config in Sigma)
- [fd](https://github.com/sharkdp/fd) (Also for Fzf)
- [nnn](https://github.com/jarun/nnn) (Default file picker, might be
    disabled / replaced)
- [npm](https://github.com/npm/cli) (For coc.nvim)
- [kitty](https://github.com/kovidgoyal/kitty) or
    [tmux](https://github.com/tmux/tmux) (optional)
- [lazygit](https://github.com/jesseduffield/lazygit) (For... lazygit
    integration)
- [python3](https://www.python.org/) (Ultisnips)

## Installation

Install vim-plug first:

```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Install Sigma.nvim:

```sh
sh -c 'curl -fLo "$HOME"/.config/nvim/lua/sigma/init.lua --create-dirs \
       https://raw.githubusercontent.com/voidekh/sigma.nvim/main/lua/sigma/init.lua'
```

## Configuration

To use the default Sigma.nvim just add this line to your init.lua:

```lua
require('sigma').setup()
```

You can pass the following options to the `setup` function:

```lua
-- Below are the defaults
local options = {
    with_lsp = true,
    lsp_servers = { 'vimls', 'lua_ls' },
    tweaks = { 'resizefix', 'highlightedyank', 'no-numbers-in-term' },
}
```

### FZF

Recommended options for fzf are as follows:

```sh
# fzf default command
export FZF_DEFAULT_COMMAND="rg -g '!{.git,node_modules,.composer}/' --hidden --no-ignore -l ''"
# fzf theming
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#a9b1d6,bg:#1a1b26,hl:#7aa2f7 --color=fg+:#c0caf5,bg+:#1a1b26,hl+:#7dcfff --color=info:#cfc9c2,prompt:#f7768e,pointer:#bb9af7 --color=marker:#9ece6a,spinner:#bb9af7,header:#73daca'
```

You should put it in your shell configuration (.bashrc/.zshrc or .profile/.zshenv)

If Neovim is started by '-e' option of terminal emulator, it might not inherit your
shell env, so you might need to add the same options in your init.lua:

```lua
vim.env.FZF_DEFAULT_COMMAND = "rg -g '!{.git,node_modules,.composer}/' --hidden --no-ignore -l ''"
vim.env.FZF_DEFAULT_OPTS = '--color=fg:#a9b1d6,bg:#1a1b26,hl:#7aa2f7 --color=fg+:#c0caf5,bg+:#1a1b26,hl+:#7dcfff --color=info:#cfc9c2,prompt:#f7768e,pointer:#bb9af7 --color=marker:#9ece6a,spinner:#bb9af7,header:#73daca'
```

Should you want to customize your fzf theme, e.g. to match colorscheme you've
chosen instead of the default kyotonight.vim (why would you do that? :( )
check out [this site](https://minsw.github.io/fzf-color-picker/).

### nnn

Since nnn file manager is a big part of intended Sigma.nvim workflow, below is
the recommended configuration (note: preview-tui plugin requires kitty or tmux):

```sh
# nnn config
BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
export NNN_PLUG='p:/usr/share/nnn/plugins/preview-tui;f:/usr/share/nnn/plugins/fzopen'
```

Colors configuration should be quite universal, as it will use your terminals
colors, so if you use a theme matching your Vim colorscheme, everything would
look right. Also be sure to tweak the nnn plugins paths to match the ones on
your system. If nnn package on your system doesn't come with its plugins, you
can download them [here](https://github.com/jarun/nnn/tree/master/plugins).

### lazygit

Only thing that is needed here is running Vim in kitty or tmux, and also having
lazygit installed. The `<leader>gg` keybinding pulls up a pane with lazygit in
current working directory.

### Overriding configuration

To override default Sigma configuration... just set your configuration changes
after calling `require('sigma').setup()` function.

### Plugins

To remove a plugin:

```lua
require('sigma').plug.remove('plugin/name')
```

Add a plugin:

```lua
require('sigma').plug.add('plugin/name', {branch = 'master'})
```

#### Configuring plugins

Here's an example from Sigma.nvim core:

```lua
require('sigma').plug.add('voidekh/kyotonight.vim', { config = function()
        require('sigma.plugins.kyotonight').setup()
    end })
```

The options table supports all the keys supported by vim-plug and config which
acts as a plugins post-initialization hook. You can override any existing plugin
configuration, by providing your own function and of course add new plugins.

These functions need to be called **BEFORE** `require('sigma').setup()`.

You can also ignore calling the setup function and use `require('sigma').plug`
as handy vim-plug wrapper and selectively call some plugin configuration.

```lua
local plug = require('sigma').plug

plug.begin()
plug.Plug('some/plugin', {
    branch = 'master',
    ['do'] = ':SomeCommand',
    config = function () 
        -- your awesome config
    end
    })
plug.done()

-- Since setup() isn't called the config functions need to be run explicitly
for _, conf in pair(require('sigma').configs) do
   conf() 
end
```

#### Configuring an LSP server 

```lua
local overrides = require('sigma.lsp.defaults')
overrides.init_options = {param = 'value'}
require('lspconfig')['pyright'].setup(overrides)
```

## Updating Sigma.nvim

All the plugins, including `sigma.nvim` are managed by `vim-plug`. Just run `:PlugUpdate` every once in a while. Or type
`u` in the dashboard or use `<leader>up` keybinding. You also should update the main `lua/sigma/init.lua` file used to
bootstrap `sigma.nvim` using command `:SigmaUpdate`, type `s` in the dashboard or use `<leader>us`.

## Features

- Dashboard with useful shortcuts
- Good looking, easy on the eyes theme
- Code commenting plugins
- Simple project management
- Privilege elevating when editing system config
- Fuzzy finder
- Fancy yet useful status and bufferline
- Autocompletion and snippets
- LSP support
- Undotree
- Nnn file manager integration
- Easy shortcuts to lazygit and full fledged terminal (kitty or tmux required)
- Auto-save
- Easy to configure remote sync
- Undotree
- Better search and replace
- Cheat.sh support
- Color strings highlighting
- Clipboard history picker
- Unicode symbols picker

## Known issues

### Cursor line gets lost

For some reason 'nocursorline' option gets set *sometimes*. I haven't tracked
the issue yet. A workaround (if you want cursorline that is) is adding following
autocmd to your init.lua:

```lua
vim.cmd[[autocmd FileType * if &ft != 'startify' && &ft != 'dashboard' | :set cursorline | endif]]
```

### After first run / change in plugins config is not loaded

Have you tried turning it off and on again? I mean, just restart nvim.
