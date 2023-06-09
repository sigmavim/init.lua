--    _____ _                                    _
--   / ___/(_)___ _____ ___  ____ _  ____ _   __(_)___ ___
--   \__ \/ / __ `/ __ `__ \/ __ `/ / __ \ | / / / __ `__ \
--  ___/ / / /_/ / / / / / / /_/ / / / / / |/ / / / / / / /
-- /____/_/\__, /_/ /_/ /_/\__,_(_)_/ /_/|___/_/_/ /_/ /_/
--        /____/
-- lua/sigma/plugins/nnn.lua

local utils = require('sigma.utils')
local M = {
    setup = function ()
        vim.g['nnn#layout'] = { window = { width = 1, height = 1, border = 'none' } }
        vim.g['nnn#replace_netrw'] = 1
        vim.g['nnn#command'] = 'nnn -a -Pp -o'

        utils.noremap('n', '<leader>fb', '<Cmd>NnnPicker<CR>')
        utils.noremap('n', '<C-n>', '<Cmd>NnnPicker %:p:h<CR>')
    end
}

return M
