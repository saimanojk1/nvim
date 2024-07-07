return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
  },
  config = function()
    local function copy_path(state)
      -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
      -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
      local node = state.tree:get_node()
      local filepath = node:get_id()
      local filename = node.name
      local modify = vim.fn.fnamemodify

      local results = {
        filepath,
        modify(filepath, ":."),
        modify(filepath, ":~"),
        filename,
        modify(filename, ":r"),
        modify(filename, ":e"),
      }

      vim.ui.select({
        "1. Absolute path: " .. results[1],
        "2. Path relative to CWD: " .. results[2],
        "3. Path relative to HOME: " .. results[3],
        "4. Filename: " .. results[4],
        "5. Filename without extension: " .. results[5],
        "6. Extension of the filename: " .. results[6],
      }, { prompt = "Choose to copy to clipboard:" }, function(choice)
        if choice then
          local i = tonumber(choice:sub(1, 1))
          if i then
            local result = results[i]
            vim.fn.setreg('+', result)
            vim.notify("Copied: " .. result)
          else
            vim.notify("Invalid selection")
          end
        else
          vim.notify("Selection cancelled")
        end
      end)
    end
    require("neo-tree").setup({
      vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {}),
      event_handlers = {
        {
          -- auto close
          event = "file_opened",
          handler = function()
            vim.cmd("Neotree close")
          end,
        },
      },
      close_if_last_window = true,
      enable_git_status = true,
      auto_clean_after_session_restore = true,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_hidden = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          always_show = {
            "*.json",
            "*.yml",
            "*.yaml",
          },
          never_show = {},
          never_show_by_pattern = {},
        },
      },
      window = {
        mappings = {
          ["Y"] = copy_path,
          -- Additional mappings
        },
      }
    })
  end,
}
