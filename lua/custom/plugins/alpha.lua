return {
	"folke/snacks.nvim",
	opts = {
		dashboard = {
			preset = {
				-- 1. Use your preferred Alpha ASCII art here
				header = [[
                                                                                      
         ████ ██████            █████      ██                     
        ███████████              █████                              
        █████████ ███████████████████ ███   ███████████   
       █████████  ███    █████████████ █████ ██████████████   
      █████████ ██████████ █████████ █████ █████ ████ █████   
    ███████████ ███    ███ █████████ █████ █████ ████ █████  
   ██████  █████████████████████ ████ █████ █████ ████ ██████ 
        ]],
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			cmd = "colorscript -e square",
			sections = {
				{ section = "header" }, -- Left Column (Logo)

				-- 1. Squares locked to the RIGHT
				{
					pane = 2,
					section = "terminal",
					cmd = "colorscript -e 24",
					height = 5,
					padding = 1,
				},

				{ section = "keys", gap = 1, padding = 1 }, -- Left Column (Menu)

				-- 2. STABLE SPACER: No 'section' key = No 'nil' crash.
				-- This adds 8 lines of empty space in the right column only.
				{ pane = 2, height = 8 },

				-- 3. Recent Files on the RIGHT
				{
					pane = 2,
					icon = "                              ",
					title = "Recent Files",
					section = "recent_files",
					indent = 25,
					padding = 1,
				},
				{
					pane = 2,
					title = "Projects",
					icon = " ",
					indent = 20,
					padding = 1,
					-- We use the 'items' key to manually provide the list
					items = function()
						local projects = require("project_nvim.project").get_recent_projects()
						local items = {}
						-- Only show the last 5 projects to keep it clean
						for i = 1, math.min(#projects, 5) do
							local path = projects[i]
							local name = vim.fn.fnamemodify(path, ":t")
							table.insert(items, {
								text = { { "󱏒 ", hl = "SnacksDashboardIcon" }, { name, hl = "SnacksDashboardDesc" } },
								action = function()
									vim.api.nvim_set_current_dir(path)
									Snacks.picker.files({ cwd = path })
								end,
								key = tostring(i), -- Assigns keys 1, 2, 3... to projects
							})
						end
						return items
					end,
				},

				{ section = "startup" },
			},
		},
	},
}
