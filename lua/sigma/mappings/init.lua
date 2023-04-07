--    _____ _                                    _
--   / ___/(_)___ _____ ___  ____ _  ____ _   __(_)___ ___
--   \__ \/ / __ `/ __ `__ \/ __ `/ / __ \ | / / / __ `__ \
--  ___/ / / /_/ / / / / / / /_/ / / / / / |/ / / / / / / /
-- /____/_/\__, /_/ /_/ /_/\__,_(_)_/ /_/|___/_/_/ /_/ /_/
--        /____/
-- lua/sigma/mappings/init.lua
-- sigma.nvim mappings
local utils = require('sigma.utils')

-- TODO: move plugin specific mapping to its plugin files
local M = {
    setup = function()
        utils.noremap('n', '<Esc>', '<Cmd>noh<CR>')
        utils.noremap('n', '<leader>uc', '<Cmd>PlugClean<CR>')
        utils.noremap('n', '<leader>up', '<Cmd>PlugUpdate<CR>')
        utils.noremap('n', '<leader>uv', '<Cmd>PlugUpgrade<CR>')
        utils.noremap('n', '<leader>us', '<Cmd>lua require("sigma").update()<CR>')
        utils.noremap('n', '<leader>fP', '<Cmd>e ~/.config/nvim/init.lua<CR>')

        if (vim.env.TERM == 'xterm-kitty') then
            utils.noremap('n', '<leader>gg', '<Cmd>call SigmaRun("lazygit -p")<C-j><CR>', { silent = true })
        else
            utils.noremap('n', '<leader>gg', '<Cmd>call SigmaRun("lazygit")<C-j><CR>', { silent = true })
        end
        utils.noremap('n', '<leader>tt', '<Cmd>call SigmaRun()<C-j><CR>', { silent = true })

        -- you've got some moves
        utils.noremap('n', '<C-u>', '<C-u>zz')
        utils.noremap('n', '<C-d>', '<C-d>zz')
        utils.noremap('n', 'n', 'nzzzv')
        utils.noremap('n', 'N', 'Nzzzv')
        utils.noremap('n', 'gg', 'ggzz')
        utils.noremap('n', 'G', 'Gzz')
        utils.noremap('n', 'gd', 'gdzz')
        utils.noremap('n', 'gD', 'gDzz')
        utils.noremap('n', 'gi', 'gizz')
        utils.noremap('n', '<C-i>', '<C-i>zz')
        utils.noremap('n', '<C-o>', '<C-o>zz')

        -- switch between windows
        utils.noremap('n', '<leader>wh', '<C-w>h')
        utils.noremap('n', '<leader>wl', '<C-w>l')
        utils.noremap('n', '<leader>wj', '<C-w>j')
        utils.noremap('n', '<leader>wk', '<C-w>k')
        utils.noremap('n', '<leader>w<Left>', '<C-w>h')
        utils.noremap('n', '<leader>w<Right>', '<C-w>l')
        utils.noremap('n', '<leader>w<Down>', '<C-w>j')
        utils.noremap('n', '<leader>w<Up>', '<C-w>k')

        -- resize windows
        utils.noremap('n', '<A-Left>', '<C-w>>')
        utils.noremap('n', '<A-Right>', '<C-w><')
        utils.noremap('n', '<A-Up>', '<C-w>+')
        utils.noremap('n', '<A-Down>', '<C-w>-')
        utils.noremap('n', '<A-h>', '<C-w>>')
        utils.noremap('n', '<A-l>', '<C-w><')
        utils.noremap('n', '<A-k>', '<C-w>+')
        utils.noremap('n', '<A-j>', '<C-w>-')
        utils.noremap('n', '<A-J>', '<C-w>_')
        utils.noremap('n', '<A-K>', '<C-w>_')
        utils.noremap('n', '<A-H>', '<C-w>|')
        utils.noremap('n', '<A-L>', '<C-w>|')
        utils.noremap('n', '<A-e>', '<C-w>=')

        utils.noremap('n', '<A-.>', '<Cmd>bn<CR>')
        utils.noremap('n', '<A-,>', '<Cmd>bp<CR>')

        -- Close buffer
        utils.noremap('n', '<A-c>', '<Cmd>bd<CR>')

        -- greatest remap ever
        utils.noremap('v', '<leader>p', '"_dP')

        -- split windows
        utils.noremap('n', '<leader>ws', '<C-w>s')
        utils.noremap('n', '<leader>wv', '<C-w>v')

        -- close window
        utils.noremap('n', '<leader>wc', '<C-w>c')

        -- escape terminal mode
        utils.noremap('t', '<C-space>', '<C-\\><C-n>')

        -- open netrw
        utils.noremap('n', '<leader>ex', '<Cmd>Ex<CR>')
    end
}

return M
