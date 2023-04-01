--    _____ _                                    _
--   / ___/(_)___ _____ ___  ____ _  ____ _   __(_)___ ___
--   \__ \/ / __ `/ __ `__ \/ __ `/ / __ \ | / / / __ `__ \
--  ___/ / / /_/ / / / / / / /_/ / / / / / |/ / / / / / / /
-- /____/_/\__, /_/ /_/ /_/\__,_(_)_/ /_/|___/_/_/ /_/ /_/
--        /____/
-- lua/sigma/plugins/fzf.lua

local utils, opts = require('sigma.utils'), { silent = true }
local M = {
    setup = function()
        utils.noremap('n', '<leader>ff', '<Cmd>FzfLua files<CR>', opts)
        utils.noremap('n', '<leader>fr', '<Cmd>FzfLua oldfiles<CR>', opts)
        utils.noremap('n', '<leader>rg',
        [[<Cmd>lua require('fzf-lua').live_grep({ cmd = "rg -g '!{.git,node_modules}/' --hidden --no-ignore --column", search = "", fzf_opts = { ['--nth'] = '2..' } })<CR>]],
        opts)
        utils.noremap('n', '<leader>bi', '<Cmd>FzfLua buffers<CR>', opts)
        utils.noremap('n', '<leader>cp', '<Cmd>FzfLua commands<CR>', opts)
        utils.noremap('n', '<leader>ll', '<Cmd>FzfLua lines<CR>', opts)
        utils.noremap('n', '<leader>gl', '<Cmd>FzfLua blines<CR>', opts)
        utils.noremap('n', '<leader>gj', '<Cmd>FzfLua jumps<CR>', opts)
        utils.noremap('n', '<leader>km', '<Cmd>FzfLua keymaps<CR>', opts)
        utils.noremap('n', '<leader>fzf', '<Cmd>FzfLua<CR>', opts)
        utils.noremap('n', '<leader>fzr', '<Cmd>FzfLua resume<CR>', opts)
        utils.noremap('n', '<leader>fzs', '<Cmd>FzfLua git_status<CR>', opts)
        utils.noremap('n', '<leader>fzc', '<Cmd>FzfLua git_commits<CR>', opts)
        utils.noremap('n', '<leader>fzb', '<Cmd>FzfLua git_branches<CR>', opts)
        utils.noremap('n', '<leader>fzd', '<Cmd>FzfLua changes<CR>', opts)
        utils.noremap('n', '<leader>ch', '<Cmd>FzfLua command_history<CR>', opts)
        utils.noremap('n', '<leader>ht', '<Cmd>FzfLua help_tags<CR>', opts)
        utils.noremap('n', '<leader>sh', '<Cmd>FzfLua search_history<CR>', opts)
    end
}

return M
