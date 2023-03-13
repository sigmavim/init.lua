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
        utils.noremap('n', '<leader>pp', '<Cmd>ProjectList<CR>')
        utils.noremap('n', '<leader>fb', '<Cmd>NnnPicker<CR>')
        utils.noremap('n', '<Esc>', '<Cmd>noh<CR>')
        utils.noremap('n', '<leader>uc', '<Cmd>PlugClean<CR>')
        utils.noremap('n', '<leader>up', '<Cmd>PlugUpdate<CR>')
        utils.noremap('n', '<leader>uv', '<Cmd>PlugUpgrade<CR>')
        utils.noremap('n', '<leader>us', '<Cmd>SigmaUpdate<CR>')
        utils.noremap('n', '<leader>ff', '<Cmd>SigmaFiles<CR>')
        utils.noremap('n', '<leader>fr', '<Cmd>SigmaRecentFiles<CR>')
        utils.noremap('n', '<leader>rg', '<Cmd>SigmaRg<CR>')
        utils.noremap('n', '<leader>fP', '<Cmd>SigmaConfig<CR>')
        utils.noremap('n', '<leader>ss', '<Cmd>SigmaDashboard<CR>')
        utils.noremap('n', '<leader>bi', '<Cmd>FzfLua buffers<CR>')
        utils.noremap('n', '<leader>cp', '<Cmd>FzfLua commands<CR>')
        utils.noremap('n', '<leader>ll', '<Cmd>FzfLua lines<CR>')
        utils.noremap('n', '<leader>gl', '<Cmd>FzfLua blines<CR>')
        utils.noremap('n', '<leader>gj', '<Cmd>FzfLua jumps<CR>')
        utils.noremap('n', '<leader>km', '<Cmd>FzfLua keymaps<CR>')
        utils.noremap('n', '<leader>S', '<cmd>lua require("spectre").open()<CR>')
        utils.noremap('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
        utils.noremap('v', '<leader>s', '<esc>:lua require("spectre").open_visual()<CR>')
        utils.noremap('n', '<leader>sp', 'viw:lua require("spectre").open_file_search()<cr>')
        utils.noremap('n', '<leader>yy', '<Cmd>lua require("neoclip.fzf")()<CR>')
        utils.noremap('n', '<C-n>', '<Cmd>NnnPicker %:p:h<CR>')

        if (vim.env.TERM == 'xterm-kitty' or vim.env.TMUX ~= '') then
            if (vim.env.TMUX ~= '') then
                utils.noremap('n', '<leader>gg', '<Cmd>call sigma#run("lazygit")<C-j><CR>', { silent = true })
            else
                utils.noremap('n', '<leader>gg', '<Cmd>call sigma#run("lazygit -p")<C-j><CR>', { silent = true })
            end
            utils.noremap('n', '<leader>gg', '<Cmd>call sigma#run()<C-j><CR>', { silent = true })
        end

        utils.noremap('n', '<leader>uu', '<Cmd>UndotreeToggle<CR>')

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
        utils.noremap('n', '<leader>w<Left> <C-w>h')
        utils.noremap('n', '<leader>w<Right> <C-w>l')
        utils.noremap('n', '<leader>w<Down> <C-w>j')
        utils.noremap('n', '<leader>w<Up> <C-w>k')

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

        -- Bufferline
        if utils.is_enabled('romgrk/barbar.nvim') then
            utils.noremap('n', '<A-.>', '<Cmd>BufferNext<CR>')
            utils.noremap('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
            utils.noremap('n', '<C-,>', '<Cmd>BufferMovePrevious<CR>')
            utils.noremap('n', '<C-.>', '<Cmd>BufferMoveNext<CR>')
            utils.noremap('n', '<A-p>', '<Cmd>BufferPin<CR>')
            utils.noremap('n', '<A-C>', '<Cmd>BufferCloseAllButCurrentOrPinned<CR>')
        else
            utils.noremap('n', '<A-.>', '<Cmd>bn<CR>')
            utils.noremap('n', '<A-,>', '<Cmd>bp<CR>')
        end

        -- Close buffer
        utils.noremap('n', '<A-c>', '<Cmd>bd<CR>')

        -- greatest remap ever
        utils.noremap('v', '<leader>p', '"_dP')

        -- split windows
        utils.noremap('n', '<leader>ws', '<C-w>s')
        utils.noremap('n', '<leader>wv', '<C-w>v')

        -- close window
        utils.noremap('n', '<leader>wc', '<C-w>c')

        -- icon picker
        utils.noremap('n', '<leader>fg', '<Cmd>IconPickerNormal nerd_font<CR>')
        utils.noremap('n', '<leader>fe', '<Cmd>IconPickerNormal emoji<CR>')
        utils.noremap('n', '<leader>fs', '<Cmd>IconPickerNormal symbols<CR>')
        utils.noremap('n', '<leader>fa', '<Cmd>IconPickerNormal alt_font<CR>')
    end
}

return M
