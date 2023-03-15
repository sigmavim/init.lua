--    _____ _                                    _
--   / ___/(_)___ _____ ___  ____ _  ____ _   __(_)___ ___
--   \__ \/ / __ `/ __ `__ \/ __ `/ / __ \ | / / / __ `__ \
--  ___/ / / /_/ / / / / / / /_/ / / / / / |/ / / / / / / /
-- /____/_/\__, /_/ /_/ /_/\__,_(_)_/ /_/|___/_/_/ /_/ /_/
--        /____/
-- lua/sigma/init.lua
-- Main sigma.nvim file

local plugins = {
    ['wmwnuk/sigma.nvim'] = { branch = 'main',['do'] = ':SigmaUpdate' },
    ['voidekh/kyotonight.vim'] = { config = function()
        require('sigma.plugins.kyotonight').setup()
    end },
    ['907th/vim-auto-save'] = { config = function()
        require('sigma.plugins.autosave').setup()
    end },
    ['eshion/vim-sync'] = { config = function()
        require('sigma.plugins.sync').setup()
    end },
    ['skywind3000/asyncrun.vim'] = 1,
    ['lambdalisue/suda.vim'] = { config = function()
        require('sigma.plugins.suda').setup()
    end },
    ['tpope/vim-abolish'] = 1,
    ['honza/vim-snippets'] = 1,
    ['dbeniamine/cheat.sh-vim'] = 1,
    ['mcchrish/nnn.vim'] = { config = function()
        require('sigma.plugins.nnn').setup()
    end },
    ['leafOfTree/vim-project'] = { config = function()
        require('sigma.plugins.project').setup()
    end },
    ['mbbill/undotree'] = { config = function()
        require('sigma.plugins.undotree').setup()
    end },
    ['junegunn/fzf'] = 1,
    ['noahfrederick/vim-skeleton'] = { config = function()
        require('sigma.plugins.skeleton').setup()
    end },
    ['mhinz/vim-startify'] = { config = function()
        require('sigma.plugins.startify').setup()
    end },
    ['nvim-lualine/lualine.nvim'] = { config = function()
        require('sigma.plugins.lualine').setup()
    end },
    ['numToStr/Comment.nvim'] = { config = function()
        require('sigma.plugins.comment').setup()
    end },
    ['kyazdani42/nvim-web-devicons'] = 1,
    ['lewis6991/gitsigns.nvim'] = { config = function()
        require('sigma.plugins.gitsigns').setup()
    end },
    ['ibhagwan/fzf-lua'] = { branch = 'main', config = function()
        require('sigma.plugins.fzf').setup()
    end },
    ['kkharji/sqlite.lua'] = { as = 'sqlite' },
    ['AckslD/nvim-neoclip.lua'] = { config = function()
        require('sigma.plugins.neoclip').setup()
    end },
    ['nvim-pack/nvim-spectre'] = { config = function()
        require('sigma.plugins.spectre').setup()
    end },
    ['romgrk/barbar.nvim'] = { config = function()
        require('sigma.plugins.bufferline').setup()
    end },
    ['nvim-lua/plenary.nvim'] = 1,
    ['norcalli/nvim-colorizer.lua'] = 1,
    ['stevearc/dressing.nvim'] = 1,
    ['ziontee113/icon-picker.nvim'] = { config = function()
        require('sigma.plugins.iconpicker').setup()
    end }
}
local configs = {}
local lsp_servers = { 'vimls', 'lua_ls' }
local Plug = function(plug_name, plug_config)
    if (type(plug_config) == "table" and type(plug_config.config) == "function")
    then
        configs[plug_name] = plug_config.config
    end

    if plug_config ~= nil then
        vim.fn['plug#'](plug_name, plug_config)
    else
        vim.fn['plug#'](plug_name)
    end
end
local plug = {
    begin = vim.fn['plug#begin'],
    done = vim.fn['plug#end'],
    add = function(plugin, config, no_override)
        no_override = no_override or 0
        config = config or 1
        if (plugins[plugin] ~= nil and no_override ~= 1)
        then
            return
        else
            plugins[plugin] = config
        end
    end,
    remove = function(plugin)
        plugins[plugin] = nil
    end
}

local update = function()
    vim.cmd [[!sh -c 'curl -fLo "$HOME"/.config/nvim/lua/sigma/init.lua --create-dirs https://raw.githubusercontent.com/wmwnuk/sigma.nvim/main/lua/sigma/init.lua']]
end

local M = {
    setup = function(options)
        options = options or {}
        vim.opt.termguicolors = true
        vim.opt.guifont = "SauceCodePro Nerd Font:h10"
        vim.opt.signcolumn = 'yes'
        vim.opt.undofile = true
        vim.opt.swapfile = true
        vim.opt.backup = true
        vim.opt.backupdir = vim.fn.stdpath('state') .. '/backup'
        vim.opt.title = true
        vim.opt.laststatus = 3
        vim.opt.showmode = false
        vim.opt.compatible = false
        vim.opt.mouse = 'a'
        vim.g.mapleader = " "
        vim.opt.syntax = 'on'
        vim.opt.clipboard = 'unnamedplus'
        vim.opt.nu = true
        vim.opt.relativenumber = true
        vim.opt.encoding = 'UTF-8'
        vim.opt.smarttab = true
        vim.opt.smartindent = true
        vim.opt.tabstop = 4
        vim.opt.softtabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = true
        vim.opt.wrap = false
        vim.opt.textwidth = 0
        vim.opt.wrapmargin = 0
        vim.opt.colorcolumn = '120'
        vim.opt.whichwrap:append '<>[]hl'
        vim.opt.cursorline = true

        local with_lsp = options.with_lsp or true
        local sigma_lsp_servers = options.lsp_servers or lsp_servers
        local tweaks = options.tweaks or { 'resizefix', 'highlightedyank' }

        if (with_lsp) then
            plug.add('williamboman/mason.nvim', 1, 1)
            plug.add('williamboman/mason-lspconfig.nvim', 1, 1)
            plug.add('neovim/nvim-lspconfig', 1, 1)
            plug.add('hrsh7th/cmp-nvim-lsp', 1, 1)
            plug.add('hrsh7th/cmp-buffer', 1, 1)
            plug.add('hrsh7th/cmp-path', 1, 1)
            plug.add('hrsh7th/cmp-cmdline', 1, 1)
            plug.add('hrsh7th/nvim-cmp', 1, 1)
            plug.add('SirVer/ultisnips', 1, 1)
            plug.add('quangnguyen30192/cmp-nvim-ultisnips', 1, 1)
            plug.add('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' }, 1)
        end

        plug.begin()
        for plugin, config in pairs(plugins) do
            if (config ~= nil) then
                if config == 1 then
                    Plug(plugin)
                else
                    Plug(plugin, config)
                end
            end
        end
        plug.done()

        vim.cmd([[autocmd VimEnter *
                \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \|   PlugInstall --sync | q
                \| endif]])

        -- Assign mappings now, so that plugins can override them
        require('sigma.mappings').setup()

        for _, plug_conf in pairs(configs) do
            plug_conf()
        end

        if (with_lsp) then
            require('sigma.lsp').setup(sigma_lsp_servers)
        end

        vim.cmd [[
function! SigmaRun(command = '', split = 'h')
    if $TERM == 'xterm-kitty'
        execute "!kitty @ launch " a:command getcwd()
    elseif $TMUX != ''
        execute "!tmux split-window -" . a:split "-c" getcwd() a:command
    else
        echoerr 'Neovim must be run in kitty terminal or tmux for SigmaRun to work'
    endif
endfunction
]]

        require('sigma.tweaks').setup(tweaks)

        vim.api.nvim_create_user_command('SigmaUpdate', update)
    end,
    update = update,
    plug = plug,
    plugins = plugins,
    configs = configs,
    lsp_servers = lsp_servers
}

return M
