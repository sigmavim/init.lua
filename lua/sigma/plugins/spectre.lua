--    _____ _                                    _
--   / ___/(_)___ _____ ___  ____ _  ____ _   __(_)___ ___
--   \__ \/ / __ `/ __ `__ \/ __ `/ / __ \ | / / / __ `__ \
--  ___/ / / /_/ / / / / / / /_/ / / / / / |/ / / / / / / /
-- /____/_/\__, /_/ /_/ /_/\__,_(_)_/ /_/|___/_/_/ /_/ /_/
--        /____/
-- lua/sigma/plugins/spectre.lua

local utils = require('sigma.utils')
local M = {
    setup = function()
        require('spectre').setup({
            find_engine = {
                ['rg'] = {
                    cmd = "rg",
                    args = {
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '-g "!.git"',
                    },
                    options = {
                        ['ignore-case'] = {
                            value = "--ignore-case",
                            icon = "[]",
                            desc = "ignore case"
                        },
                        ['hidden'] = {
                            value = "--hidden",
                            desc = "hidden file",
                            icon = "[﬒]"
                        },
                        ['no-ignore'] = {
                            value = "--no-ignore",
                            desc = "no .gitignore",
                            icon = "[]"
                        },
                    }
                }
            }
        })

        utils.noremap('n', '<leader>S', '<cmd>lua require("spectre").open()<CR>')
        utils.noremap('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
        utils.noremap('v', '<leader>s', '<esc>:lua require("spectre").open_visual()<CR>')
        utils.noremap('n', '<leader>sp', 'viw:lua require("spectre").open_file_search()<cr>')
    end
}

return M
