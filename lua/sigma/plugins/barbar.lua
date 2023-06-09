--    _____ _                                    _
--   / ___/(_)___ _____ ___  ____ _  ____ _   __(_)___ ___
--   \__ \/ / __ `/ __ `__ \/ __ `/ / __ \ | / / / __ `__ \
--  ___/ / / /_/ / / / / / / /_/ / / / / / |/ / / / / / / /
-- /____/_/\__, /_/ /_/ /_/\__,_(_)_/ /_/|___/_/_/ /_/ /_/
--        /____/
-- lua/sigma/plugins/bufferline.lua

local utils = require('sigma.utils')
local M = {
    setup = function()
        require('barbar').setup({
            icons = {
                button = '󰖭',
                separator = { left = '' },
                inactive = { separator = { left = '' } },
                pinned = { button = '', filename = true }
            }
        })

        utils.noremap('n', '<A-.>', '<Cmd>BufferNext<CR>')
        utils.noremap('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
        utils.noremap('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>')
        utils.noremap('n', '<A->>', '<Cmd>BufferMoveNext<CR>')
        utils.noremap('n', '<A-p>', '<Cmd>BufferPin<CR>')
        utils.noremap('n', '<A-P>', '<Cmd>BufferCloseAllButCurrentOrPinned<CR>')
    end
}

return M
