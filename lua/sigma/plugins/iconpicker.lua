--    _____ _                                    _
--   / ___/(_)___ _____ ___  ____ _  ____ _   __(_)___ ___
--   \__ \/ / __ `/ __ `__ \/ __ `/ / __ \ | / / / __ `__ \
--  ___/ / / /_/ / / / / / / /_/ / / / / / |/ / / / / / / /
-- /____/_/\__, /_/ /_/ /_/\__,_(_)_/ /_/|___/_/_/ /_/ /_/
--        /____/
-- lua/sigma/plugins/iconpicker.lua

local utils = require('sigma.utils')
local M = {
    setup = function ()
        require("icon-picker").setup({ disable_legacy_commands = true })

        utils.noremap('n', '<leader>fg', '<Cmd>IconPickerNormal nerd_font<CR>')
        utils.noremap('n', '<leader>fe', '<Cmd>IconPickerNormal emoji<CR>')
        utils.noremap('n', '<leader>fs', '<Cmd>IconPickerNormal symbols<CR>')
        utils.noremap('n', '<leader>fa', '<Cmd>IconPickerNormal alt_font<CR>')
    end
}

return M
