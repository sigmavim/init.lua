--    _____ _                                    _
--   / ___/(_)___ _____ ___  ____ _  ____ _   __(_)___ ___
--   \__ \/ / __ `/ __ `__ \/ __ `/ / __ \ | / / / __ `__ \
--  ___/ / / /_/ / / / / / / /_/ / / / / / |/ / / / / / / /
-- /____/_/\__, /_/ /_/ /_/\__,_(_)_/ /_/|___/_/_/ /_/ /_/
--        /____/
-- lua/sigma/init.lua
-- Main sigma.nvim file

local plugins = {
    ['sigmavim/init.lua'] = { branch = 'main', ['do'] = ':SigmaUpdate' },
    ['sigmavim/kyotonight'] = { tag = 'v1.0.0', config = function()
        require('sigma.plugins.kyotonight').setup()
    end },
    ['sigmavim/skeleton'] = { tag = 'v1.0.2', config = function()
        require('sigma.plugins.skeleton').setup()
    end },
    ['907th/vim-auto-save'] = { commit = '2e3e54e', config = function()
        require('sigma.plugins.autosave').setup()
    end },
    ['eshion/vim-sync'] = { commit = '8456c14', config = function()
        require('sigma.plugins.sync').setup()
    end },
    ['skywind3000/asyncrun.vim'] = { tag = '2.11.16' },
    ['lambdalisue/suda.vim'] = { tag = 'v0.4.1', config = function()
        require('sigma.plugins.suda').setup()
    end },
    ['tpope/vim-abolish'] = { commit = 'cb3dcb2' },
    ['honza/vim-snippets'] = { commit = '76e35f3' },
    ['mcchrish/nnn.vim'] = { commit = 'e0104e3', config = function()
        require('sigma.plugins.nnn').setup()
    end },
    ['leafOfTree/vim-project'] = { commit = 'f6aa4e8', config = function()
        require('sigma.plugins.project').setup()
    end },
    ['mbbill/undotree'] = { commit = '485f01e', config = function()
        require('sigma.plugins.undotree').setup()
    end },
    ['mhinz/vim-startify'] = { commit = '81e36c3', config = function()
        require('sigma.plugins.startify').setup()
    end },
    ['nvim-lualine/lualine.nvim'] = { commit = '05d78e9', config = function()
        require('sigma.plugins.lualine').setup()
    end },
    ['numToStr/Comment.nvim'] = { tag = 'v0.8.0', config = function()
        require('sigma.plugins.comment').setup()
    end },
    ['nvim-tree/nvim-web-devicons'] = { commit = '2a12502' },
    ['lewis6991/gitsigns.nvim'] = { commit = '4455bb5', config = function()
        require('sigma.plugins.gitsigns').setup()
    end },
    ['ibhagwan/fzf-lua'] = { commit = '8d6b638', config = function()
        require('sigma.plugins.fzf').setup()
    end },
    ['kkharji/sqlite.lua'] = { commit = 'b7e28c8', as = 'sqlite' },
    ['AckslD/nvim-neoclip.lua'] = { commit = '4e406ae', config = function()
        require('sigma.plugins.neoclip').setup()
    end },
    ['nvim-pack/nvim-spectre'] = { commit = '1abe23e', config = function()
        require('sigma.plugins.spectre').setup()
    end },
    ['romgrk/barbar.nvim'] = { tag = 'v1.6.5', config = function()
        require('sigma.plugins.barbar').setup()
    end },
    ['nvim-lua/plenary.nvim'] = { commit = '499e074' },
    ['norcalli/nvim-colorizer.lua'] = { commit = '36c610a' },
    ['stevearc/dressing.nvim'] = { commit = 'f16d758' },
    ['ziontee113/icon-picker.nvim'] = { commit = 'e6dca18', config = function()
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
    vim.cmd [[!sh -c 'curl -fLo "$HOME"/.config/nvim/lua/sigma/init.lua --create-dirs https://raw.githubusercontent.com/sigmavim/init.lua/main/lua/sigma/init.lua']]
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
        local tweaks = options.tweaks or { 'resizefix', 'highlightedyank', 'no-numbers-in-term' }

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
        let s:split = a:split
        if s:split == 'v'
            let s:split = 'h'
        else
            let s:split = 'v'
        endif
            
        execute "!tmux split-window -" .. s:split "-c" getcwd() a:command
    else
        if a:split == 'h'
            split | execute "term" .. " " .. a:command
        else
            vsplit | execute "term" .. " " .. a:command
        endif
    endif
endfunction
]]

        require('sigma.tweaks').setup(tweaks)

        vim.api.nvim_create_user_command('SigmaUpdate', update, { desc = "Update Sigma.nvim bootstrap file" })
    end,
    update = update,
    plug = plug,
    plugins = plugins,
    configs = configs,
    lsp_servers = lsp_servers
}

return M
