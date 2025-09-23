-- Define a function that adds a specific header based on the filetype
local function add_header()
  -- Get the current filetype
  local filetype = vim.bo.filetype

  -- Define the headers for different languages
  local headers = {
    python = [[
# Copyright (c) %s Sri Sai Manoj Kommineni. All rights reserved.
]],
  }

  -- Get the current date in the format YYYY-MM-DD
  local date = os.date("%Y")

  -- Choose the appropriate header based on the filetype or use the default
  local header = headers[filetype] or headers.default

  -- Format the header with the current date
  header = string.format(header, date)

  -- Get the current buffer
  local bufnr = vim.api.nvim_get_current_buf()

  -- Insert the header at the top of the file
  vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, vim.split(header, '\n'))

  -- Optionally move the cursor down after the header
  vim.api.nvim_win_set_cursor(0, { 10, 0 })
end

-- Create a Neovim command to invoke the add_header function
vim.api.nvim_create_user_command('PersonalHeader', add_header, {})

vim.keymap.set("n", "<leader>ph", ":PersonalHeader<CR>:w<CR>", {})
return {}

