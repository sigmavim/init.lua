--    _____ _                                    _
--   / ___/(_)___ _____ ___  ____ _  ____ _   __(_)___ ___
--   \__ \/ / __ `/ __ `__ \/ __ `/ / __ \ | / / / __ `__ \
--  ___/ / / /_/ / / / / / / /_/ / / / / / |/ / / / / / / /
-- /____/_/\__, /_/ /_/ /_/\__,_(_)_/ /_/|___/_/_/ /_/ /_/
--        /____/
-- lua/sigma/plugins/neoclip.lua

local utils = require('sigma.utils')
local M = {
    setup = function()
        require('neoclip').setup({
            default_register = "+",
            enable_persistent_history = true,
            continuous_sync = true
        })

        utils.noremap('n', '<leader>yy', '<Cmd>lua require("neoclip.fzf")()<CR>')
    end
}

return M
