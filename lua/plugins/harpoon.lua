return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon"):setup()
    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    -- vim.keymap.set('n', '<leader>fr', builtin.resume, {})
    vim.keymap.set("n", "<leader>hf", function() toggle_telescope(harpoon:list()) end,
      { desc = "Open harpoon window" })
  end,
  keys = {
    { "<leader>ha",  function() require("harpoon"):list():add() end,     desc = "harpoon add file", },
    {
      "<leader>hj",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "harpoon quick menu",
    },
    { "<leader>hn", function() require("harpoon"):list():next() end,    desc = "harpoon menu next", },
    { "<leader>hb", function() require("harpoon"):list():prev() end,    desc = "harpoon menu prev", },
    { "<leader>1",  function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
    { "<leader>2",  function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
    { "<leader>3",  function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
    { "<leader>4",  function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
    { "<leader>5",  function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
  },
}
