# Sigma.nvim

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

![dashboard](https://imgur.com/B6j6H4B.png) ![fzf](https://imgur.com/4G1QokS.png)
![split](https://imgur.com/9fyyv3n.png) ![lazygit pane](https://imgur.com/ClilEoh.png)

You might have already seen NvChad, but you want a simpler config and be a Chad
too? Sigma.vim was made for you.

```sh
............................................................
............................... ... ........................
..................... ......'...,,.... .....................
...................  ..'''''',''';;;;'......................
................... ..',,;:::cclodxxdo;.....................
..................  ...''',,,;:ccllllc;.....................
..................   ...',;::::clllcc:,.....................
................... .... ............','....................
......................      ...      ..',,..................
......................... ...:;.....',,'....................
...................  .......'cl,.'......''..................
...................    ...........'..  .....................
...................             ....   .....................
...................           ...  .    ....................
.....................                 ......................
.....................                .......................
.....................               ...''...................
....................               ....';::,................
................'...              ....'';:clool:,...........
..........',,''.....             ....',;:ccccloodddl;.......
.......,;;;;,''......           ..',;:cloooooodoooodddl;'...
',,,;;:::;;;;,''''....         ...';:clloloooooddoodxxxxdddd
;:::::::::;;;,,,''...............';:cllllcllloooodddddddddoo
;;;;;;;;;;;;;;,,,'''......'''....',;::cccccllllllllllllllllc
,,,,,,,,,;;;;;;;,,,,,,,,,,,,;'...'',;:::ccllllllllccc::;;;;;
....'',,,,,,;;;;;;;;;;;;;;;;;,..',,;;:::cclllccccc::;;,''.''
......'''',,,,,;;;;;;;;;;;;::'..'',;;::::ccccc::::;,,,'.....
. ........'''',,,;;;;;;;;,;;;....'',,,;;;;;;;;;;,,,''....   
   ...........'',,,,,,;;;;;;;.....'''',,,,,,''''........    
    ............''''''''''''.............'............
```

## Why another Vim distribution

Most of these distributions are pretty complex, and usually happen to be a pain
to actually replace some base plugins.

## What is Sigma.nvim

Sigma is meant to be simple. It uses vim-plug as plugin manager, which is also
wrapped in Lua functions, which allows full control over what plugins from base
set are actually used.

Sigma comes with sane (or maybe opinionated?) defaults and utilities to make
your init.lua as small and readable as possible.

Sigma comes with kyotonight.vim theme, which might easily be changed to any
theme of your choice. There is also a plan of adding a possibility to create
your own colorscheme providing just color palette.

Sigma uses fzf which powers all the fuzzy finding in the default config. Check
the recommended config section for FZF.

Sigma uses nnn as file picker and file browser in place of netrw, it also 
doesn't provide any file-tree plugin.

Rationale for this choices is just... keeping it simple. Use the same tools
inside of Neovim which you would use outside of it. Fzf is great all around fuzzy
finder, unlike Telescope which might be amazing, but it's Neovim only.
Nnn is a full blown, fully functional file manager. No file browser plugin can
compare with that. And again, it's a tool for everyday use, not just in Neovim.

If you prefer different workflow, replacing nnn.vim with a file-tree plugin of
choice is just removing one plugin, adding another one, and replacing 2 remaps.
You can also add a file-tree plugin on top of nnn, so you might just want to 
replace only one remap, <C-n> with toggling your file-tree.

If you don't want fzf, there would be a lot more changes to do, and it might
miss the point of making your init.lua simple, as there would be at least dozen
remaps to replace, and Telescope, which seems an only alternative here, requires
a bunch of plugins and configuration to replicate what Sigma.nvim offers. So, if
you just hate fzf or love Telescope, you might give Sigma and fzf a chance, but
if you'd still want Telescope, NvChad might be a better choice.

Intended git workflow is using lazygit in a kitty / tmux pane
opened by <leader>gg keybinding. It follows the same rationale of using tools
usable outside of Neovim, but you can easily install / use your preferred plugin
for git... as the actual lazygit integration in Sigma is this single keybinding
for opening lazygit in current working directory. There's no plugin for that in
the base set.

In the end, you might always take parts of Sigma.nvim as inspiration for making
your own config, which is also a valid use case for this little project. :)

## Dependencies

- [NerdFont](https://github.com/ryanoasis/nerd-fonts)
- [Fzf](https://github.com/junegunn/fzf) - all the fuzzy finding
- [Ripgrep](https://github.com/BurntSushi/ripgrep) - for Fzf default config in Sigma
- [Fd](https://github.com/sharkdp/fd) - also for Fzf
- [Nnn](https://github.com/jarun/nnn) - default file picker, might be disabled / replaced
- [Npm](https://github.com/npm/cli) - for Mason / LSP
- [Kitty](https://github.com/kovidgoyal/kitty) or [Tmux](https://github.com/tmux/tmux) - for lazygit / dropdown terminal / nnn preview-tui
- [Lazygit](https://github.com/jesseduffield/lazygit) - lazygit integration
- [Python 3](https://www.python.org/) - Ultisnips for nvim-cmp

## Installation

Install vim-plug first:

```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Install Sigma.nvim:

```sh
sh -c 'curl -fLo "$HOME"/.config/nvim/lua/sigma/init.lua --create-dirs \
       https://raw.githubusercontent.com/wmwnuk/sigma.nvim/main/lua/sigma/init.lua'
```

## Configuration

To use the default SigmaVimRc just add this line to your .vimrc or init.lua:

```lua
require('sigma').setup()
```

You can pass the following options to the `setup` function:

```lua
-- Below are the defaults
local options = {
    with_lsp = true,
    lsp_servers = { 'vimls', 'lua_ls' },
    tweaks = { 'resizefix', 'highlightedyank' },
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

Since nnn file manager is a big part of intended SigmaVimRc workflow, below is
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
