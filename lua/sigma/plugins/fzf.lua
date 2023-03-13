--    _____ _                                    _
--   / ___/(_)___ _____ ___  ____ _  ____ _   __(_)___ ___
--   \__ \/ / __ `/ __ `__ \/ __ `/ / __ \ | / / / __ `__ \
--  ___/ / / /_/ / / / / / / /_/ / / / / / |/ / / / / / / /
-- /____/_/\__, /_/ /_/ /_/\__,_(_)_/ /_/|___/_/_/ /_/ /_/
--        /____/
-- lua/sigma/plugins/fzf.lua

local utils = require('sigma.utils')
local M = {
    setup = function ()
        utils.noremap('n', '<leader>ff', '<Cmd>FzfLua files<CR>')
        utils.noremap('n', '<leader>fr', '<Cmd>FzfLua oldfiles<CR>')
        utils.noremap('n', '<leader>rg', [[<Cmd>lua require('fzf-lua').live_grep({ cmd = "rg -g '!{.git,node_modules}/' --hidden --no-ignore --column", search = "", fzf_opts = { ['--nth'] = '2..' } })<CR>]])
        utils.noremap('n', '<leader>bi', '<Cmd>FzfLua buffers<CR>')
        utils.noremap('n', '<leader>cp', '<Cmd>FzfLua commands<CR>')
        utils.noremap('n', '<leader>ll', '<Cmd>FzfLua lines<CR>')
        utils.noremap('n', '<leader>gl', '<Cmd>FzfLua blines<CR>')
        utils.noremap('n', '<leader>gj', '<Cmd>FzfLua jumps<CR>')
        utils.noremap('n', '<leader>km', '<Cmd>FzfLua keymaps<CR>')
    end
}

return M
