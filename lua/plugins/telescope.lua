return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
        "junegunn/fzf"
    },
    keys = {
        {
            "<leader>/",
            false,
        },
        {
            "<leader><space>",
            false,
        },
        {
            "<leader>fF",
            false,
        },
        { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Files" },
        { "<leader>,",  false },
        {
            "fr",
            function()
                local telescope = require("telescope")
                -- telescope.setup({
                --   defaults = {
                --     -- hidden = true,
                --     file_ignore_patterns = {
                --       "node_modules",
                --       "build",
                --       "dist",
                --       "yarn.lock",
                --       ".git",
                --       ".yarn",
                --       "storybook-static",
                --       ".gitignore",
                --     },
                --   },
                -- })
                telescope.extensions.file_browser.file_browser({
                    respect_gitignore = false,
                    hidden = true,
                    grouped = true,
                    previewer = false,
                    initial_mode = "normal",
                    layout_config = { height = 40 },
                })
            end,
        },
        {
            "ff",
            function()
                local telescope = require("telescope")
                local function telescope_buffer_dir()
                    return vim.fn.expand("%:p:h")
                end
                telescope.extensions.file_browser.file_browser({
                    path = "%:p:h",
                    cwd = telescope_buffer_dir(),
                    respect_gitignore = false,
                    hidden = true,
                    grouped = true,
                    previewer = false,
                    initial_mode = "normal",
                    layout_config = { height = 40 },
                })
            end,
        },
        {
            "op",
            function()
                local telescope = require("telescope")
                telescope.extensions.file_browser.file_browser({
                    path = "/Users/bippan/Documents/code",
                    cwd = "/Users/bippan/Documents/code",
                    respect_gitignore = false,
                    hidden = true,
                    grouped = true,
                    previewer = false,
                    initial_mode = "normal",
                    layout_config = { height = 40 },
                })
            end,
        },
        {
            "<leader>gc",
            "<cmd>Telescope git_branches<cr>",
            desc = "Git branches",
        },
    },
    config = function(_, opts)
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local fb_actions = require("telescope").extensions.file_browser.actions
        local Util = require("lazy.core.util")

        opts.defaults = Util.merge(opts.defaults, {
            wrap_results = true,
            layout_strategy = "horizontal",
            layout_config = { prompt_position = "top" },
            sorting_strategy = "ascending",
            winblend = 0,
            mappings = {
                n = {},
            },
            hidden = true,
            file_ignore_patterns = {
                "node_modules",
                "build",
                "dist",
                "yarn.lock",
                ".git",
                ".yarn",
                "storybook-static",
                ".gitignore",
            },
        })
        opts.pickers = {
            diagnostics = {
                theme = "ivy",
                initial_mode = "normal",
                layout_config = {
                    preview_cutoff = 9999,
                },
            },
            git_branches = {
                mappings = {
                    ["i"] = { ["<cr>"] = actions.git_switch_branch },
                },
            },
        }

        opts.extensions = {
            file_browser = {
                theme = "dropdown",
                hijack_newtr = true,
                mappings = {
                    ["n"] = {
                        ["n"] = fb_actions.create,
                        ["d"] = fb_actions.remove,
                        ["m"] = fb_actions.move,
                        ["r"] = fb_actions.rename,
                        ["h"] = fb_actions.goto_parent_dir,
                        ["/"] = function()
                            vim.cmd("startinsert")
                        end,
                        ["c-u"] = function(prompt_bufnr)
                            for i = 1, 10 do
                                actions.move_selection_previous(prompt_bufnr)
                            end
                        end,
                        ["c-d"] = function(prompt_bufnr)
                            for i = 1, 10 do
                                actions.move_selection_next(prompt_bufnr)
                            end
                        end,
                        ["pageup"] = actions.preview_scrolling_up,
                        ["pagedown"] = actions.preview_scrolling_down,
                        ["cd"] = function(prompt_bufnr)
                            local selection = require("telescope.actions.state").get_selected_entry()
                            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                            require("telescope.actions").close(prompt_bufnr)
                            -- Depending on what you want put `cd`, `lcd`, `tcd`
                            vim.cmd(string.format("silent cd %s", dir))
                        end,
                        ["o"] = function()
                            local selection = require("telescope.actions.state").get_selected_entry()
                            local folderName = vim.fn.fnamemodify(selection.path, ":p:h:t")
                            local folderPath = vim.fn.fnamemodify(selection.path, ":p:h")
                            local command = string.format("!tmux new -d -s %s -c '%s' 'nvim .'", folderName, folderPath)
                            print(command)
                            vim.cmd(command)
                        end,
                    },
                },
            },
        }
        telescope.setup(opts)
        -- require("telescope").load_extension("fzf")
        require("telescope").load_extension("file_browser")
    end,
}
