# Sigma.nvim

*Screenshots coming soon*

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

## What is Sigma.vim

...

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

### Cursor line gets lost in Neovim

For some reason 'nocursorline' option gets set *sometimes*. I haven't tracked
the issue yet. A workaround (if you want cursorline that is) is adding following
autocmd to your init.lua:

```lua
vim.cmd[[autocmd FileType * if &ft != 'startify' && &ft != 'dashboard' | :set cursorline | endif]]
```
