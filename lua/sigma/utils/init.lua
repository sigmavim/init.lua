--    _____ _                                    _
--   / ___/(_)___ _____ ___  ____ _  ____ _   __(_)___ ___
--   \__ \/ / __ `/ __ `__ \/ __ `/ / __ \ | / / / __ `__ \
--  ___/ / / /_/ / / / / / / /_/ / / / / / |/ / / / / / / /
-- /____/_/\__, /_/ /_/ /_/\__,_(_)_/ /_/|___/_/_/ /_/ /_/
--        /____/
-- lua/sigma/utils/init.lua
-- Lua util functions for Neovim

local sigma = require('sigma')

local keyset = function(mode, keymap, command, opts)
    vim.keymap.set(mode, keymap, command, opts)
end

local M = {
    is_enabled = function(plugin)
        return sigma.plugins[plugin] ~= nil and sigma.plugins[plugin] ~= 0
    end,
    keyset = keyset,
    noremap = function(mode, keymap, command, opts)
        opts = opts or {}
        opts.noremap = true
        keyset(mode, keymap, command, opts)
    end,
    map = function(mode, keymap, command, opts)
        opts.noremap = false
        keyset(mode, keymap, command, opts)
    end
}

return M
