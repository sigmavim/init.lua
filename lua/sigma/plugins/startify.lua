--    _____ _                                    _
--   / ___/(_)___ _____ ___  ____ _  ____ _   __(_)___ ___
--   \__ \/ / __ `/ __ `__ \/ __ `/ / __ \ | / / / __ `__ \
--  ___/ / / /_/ / / / / / / /_/ / / / / / |/ / / / / / / /
-- /____/_/\__, /_/ /_/ /_/\__,_(_)_/ /_/|___/_/_/ /_/ /_/
--        /____/
-- lua/sigma/plugins/startify.lua

local utils = require('sigma.utils')
local M = {
    setup = function()
        vim.g.startify_custom_header = {
            [[      _____ _                                    _              ]],
            [[     / ___/(_)___ _____ ___  ____ _  ____ _   __(_)___ ___      ]],
            [[     \__ \/ / __ `/ __ `__ \/ __ `/ / __ \ | / / / __ `__ \     ]],
            [[    ___/ / / /_/ / / / / / / /_/ / / / / / |/ / / / / / / /     ]],
            [[   /____/_/\__, /_/ /_/ /_/\__,_(_)_/ /_/|___/_/_/ /_/ /_/      ]],
            [[          /____/                                                ]],
            [[   烈NEOVIM                                                     ]]
        }
        vim.g.startify_custom_footer = vim.cmd [[call startify#pad(split(system('echo "In order to exit Vim, press and hold the Power button"'), '\n'))]]
        vim.g.startify_lists = {
            { type = 'files',    header = { '   Recent Files' } },
            { type = 'commands', header = { '   Commands' } },
            { type = 'bookmarks', header = { '   Bookmarks' } },
        }
        vim.g.startify_commands = {
            { p = { '  Open project      SPC p p', 'ProjectList' } },
            { r = { '  Recent files      SPC f r', 'SigmaRecentFiles' } },
            { f = { '  Find files        SPC f f', 'SigmaFiles' } },
            { n = { '  File browser      SPC f b', 'NnnPicker' } },
            { z = { '  Find word         SPC r g', 'SigmaRg' } },
            { s = { '烈 Update SigmaVimRc SPC u s', 'SigmaUpdate' } },
            { u = { '  Update plugins    SPC u p', 'PlugUpdate' } },
            { c = { '  Configure         SPC f P', 'SigmaConfig' } },
        }
        function _G.webDevIcons(path)
            local filename = vim.fn.fnamemodify(path, ':t')
            local extension = vim.fn.fnamemodify(path, ':e')
            return require 'nvim-web-devicons'.get_icon(filename, extension, { default = true })
        end

        vim.cmd [[function! StartifyEntryFormat() abort
                return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
            endfunction]]

        utils.noremap('n', '<leader>ss', '<Cmd>Startify<CR>')
    end
}

return M
