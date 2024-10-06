local config = require("nvpython.config")
local utils = require("nvpython.utils")
local M = {}

M.setup = function(opts)
  config.opts = vim.tbl_deep_extend("force", config.opts, opts or {})
  vim.api.nvim_create_user_command("SendBlock", function(args)
    utils.send_block(args.line1, args.line2)
  end, { desc = "Send visual block", force = true, nargs = 0, range = "%" })

  vim.api.nvim_create_user_command("SendLine", function(_)
    utils.send_line()
  end, { desc = "Send line", force = true, nargs = 0, range = "%" })
end

return M
