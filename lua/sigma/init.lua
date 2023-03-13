--    _____ _                                    _
--   / ___/(_)___ _____ ___  ____ _  ____ _   __(_)___ ___
--   \__ \/ / __ `/ __ `__ \/ __ `/ / __ \ | / / / __ `__ \
--  ___/ / / /_/ / / / / / / /_/ / / / / / |/ / / / / / / /
-- /____/_/\__, /_/ /_/ /_/\__,_(_)_/ /_/|___/_/_/ /_/ /_/
--        /____/
-- lua/sigma/init.lua
-- Main sigma.nvim file

local plugins = {
    ['wmwnuk/sigma.nvim'] = { branch = 'main' },
    ['voidekh/kyotonight.vim'] = { ['do'] = function()
        require('sigma.plugins.kyotonight').setup()
    end },
    ['907th/vim-auto-save'] = { ['do'] = function()
        require('sigma.plugins.autosave').setup()
    end },
    ['eshion/vim-sync'] = { ['do'] = function()
        require('sigma.plugins.sync').setup()
    end },
    ['skywind3000/asyncrun.vim'] = 1,
    ['lambdalisue/suda.vim'] = { ['do'] = function()
        require('sigma.plugins.suda').setup()
    end },
    ['tpope/vim-abolish'] = 1,
    ['honza/vim-snippets'] = 1,
    ['dbeniamine/cheat.sh-vim'] = 1,
    ['mcchrish/nnn.vim'] = { ['do'] = function()
        require('sigma.plugins.nnn').setup()
    end },
    ['leafOfTree/vim-project'] = 1,
    ['mbbill/undotree'] = 1,
    ['junegunn/fzf'] = 1,
    ['noahfrederick/vim-skeleton'] = { ['do'] = function()
        require('sigma.plugins.skeleton').setup()
    end },
    ['mhinz/vim-startify'] = { ['do'] = function()
        require('sigma.plugins.startify').setup()
    end },
    ['nvim-lualine/lualine.nvim'] = 1,
    ['numToStr/Comment.nvim'] = { ['do'] = function()
        require('sigma.plugins.comment').setup()
    end },
    ['kyazdani42/nvim-web-devicons'] = 1,
    ['lewis6991/gitsigns.nvim'] = { ['do'] = function()
        require('sigma.plugins.gitsigns').setup()
    end },
    ['ibhagwan/fzf-lua'] = { branch = 'main' },
    ['kkharji/sqlite.lua'] = { as = 'sqlite' },
    ['AckslD/nvim-neoclip.lua'] = { ['do'] = function()
        require('sigma.plugins.neoclip').setup()
    end },
    ['nvim-pack/nvim-spectre'] = { ['do'] = function()
        require('sigma.plugins.spectre').setup()
    end },
    ['romgrk/barbar.nvim'] = { ['do'] = function()
        require('sigma.plugins.bufferline').setup()
    end },
    ['nvim-lua/plenary.nvim'] = 1,
    ['norcalli/nvim-colorizer.lua'] = 1,
    ['stevearc/dressing.nvim'] = 1,
    ['ziontee113/icon-picker.nvim'] = {['do'] = function ()
        require('sigma.plugins.iconpicker').setup()
    end}
}
local lsp_servers = { 'vimls', 'lua_ls' }
local Plug = vim.fn['plug#']
local plug = {
    begin = vim.fn['plug#begin'],
    done = vim.fn['plug#end'],
    add = function(plugin, config, override)
        if (plugins[plugin] ~= nil and override)
        then
            plugins[plugin] = config or 1
        end
    end,
    remove = function(plugin)
        plugins[plugin] = nil
    end
}

local M = {
    setup = function(options)
        vim.opt.termguicolors = 1
        vim.opt.guifont = "SauceCodePro Nerd Font:h10"
        vim.opt.signcolumn = 1
        vim.opt.undofile = 1
        vim.opt.swapfile = 1
        vim.opt.backup = 1
        vim.opt.backupdir = '~/.local/state/nvim/backup'
        vim.opt.title = 1
        vim.opt.laststatus = 3
        vim.opt.noshowmode = 1
        vim.opt.nocompatible = 1
        vim.opt.mouse = 'a'
        vim.g.mapleader = " "
        vim.opt.syntax = 1
        vim.opt.clipboard = 'unnamedplus'
        vim.opt.nu = 1
        vim.opt.relativenumber = 1
        vim.opt.encoding = 'UTF-8'
        vim.opt.smarttab = 1
        vim.opt.smartindent = 1
        vim.opt.tabstop = 4
        vim.opt.softtabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = 1
        vim.opt.nowrap = 1
        vim.opt.textwidth = 0
        vim.opt.wrapmargin = 0
        vim.opt.colorcolumn = 120
        vim.opt.whichwrap = vim.opt.whichwrap .. '<>[]hl'
        vim.opt.cursorline = 1

        local with_lsp = options.with_lsp or true
        local sigma_lsp_servers = options.lsp_servers or lsp_servers
        local tweaks = options.tweaks or { 'resizefix', 'highlightedyank' }

        if (with_lsp) then
            plug.add('williamboman/mason.nvim')
            plug.add('williamboman/mason-lspconfig.nvim')
            plug.add('neovim/nvim-lspconfig')
            plug.add('hrsh7th/cmp-nvim-lsp')
            plug.add('hrsh7th/cmp-buffer')
            plug.add('hrsh7th/cmp-path')
            plug.add('hrsh7th/cmp-cmdline')
            plug.add('hrsh7th/nvim-cmp')
            plug.add('SirVer/ultisnips')
            plug.add('quangnguyen30192/cmp-nvim-ultisnips')
            plug.add('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
        end

        plug.begin()
        for plugin, config in pairs(plugins) do
            Plug(plugin, config)
        end
        plug.done()

        vim.cmd([[autocmd VimEnter *
                \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \|   PlugInstall --sync | q
                \| endif]])


        if (with_lsp) then
            require('sigma.lsp').setup(sigma_lsp_servers)
        end

        vim.cmd [[
command! SigmaRecentFiles :FzfLua oldfiles
command! SigmaFiles :FzfLua files
command! SigmaRg :lua require('fzf-lua').live_grep({ cmd = "rg -g '!{.git,node_modules}/' --hidden --no-ignore --column", search = "", fzf_opts = { ['--nth'] = '2..' } })
command! SigmaConfig :e ~/.config/nvim/lua/init.lua
]]

        vim.cmd [[
function! sigma#run(command = '', split = 'h')
    if $TERM == 'xterm-kitty'
        execute "!kitty @ launch " a:command getcwd()
    elseif $TMUX != ''
        execute "!tmux split-window -" . a:split "-c" getcwd() a:command
    else
        echoerr 'Vim must be run in kitty terminal or tmux for sigma#run to work'
    endif
endfunction
]]

        require('sigma.tweaks').setup(tweaks)
        require('sigma.mappings').setup()
    end,
    plug = plug,
    plugins = plugins
}

return M
