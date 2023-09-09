vim.api.nvim_create_user_command('Note',
  function(opts)
    local name = opts.fargs[1]
    local date = os.date("%Y-%m-%d")
    local current_file = vim.api.nvim_buf_get_name(0)
    local dir = vim.fs.dirname(current_file)
    local note_path = dir .. "/" .. date .. "-" .. name .. ".md"
    
    vim.api.nvim_command('vsplit ' .. note_path)
    vim.cmd("w")
  end,
  { nargs = 1 })
