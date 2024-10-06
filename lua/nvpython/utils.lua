local config = require("nvpython.config")
local nvterms = require("nvterm.terminal")
local api = vim.api
local log = function(item)
  if config.opts.debug then
    print(vim.inspect(item))
  end
end

local function sleep(n)
  os.execute("sleep " .. tonumber(n))
end

local M = {}

M.trim_lines = function(lines)
  local trimmed_line
  local result = {}
  for _, line in ipairs(lines) do
    trimmed_line = string.gsub(line, "^%s*", "")
    if trimmed_line ~= "" then
      table.insert(result, line)
    end
  end
  log({ trim_lines = result })
  return result
end

M.get_indent_size = function(lines)
  local min_indent = math.huge
  for _, line in ipairs(lines) do
    local indent = string.match(line, "^%s*")
    if indent == nil then
      indent = ""
    end
    min_indent = math.min(min_indent, #indent)
  end
  return min_indent
end

M.trim_leading_whitespace = function(lines)
  local indent_size = M.get_indent_size(lines)
  local result = {}
  local trimmed_line
  for _, line in ipairs(lines) do
    trimmed_line = string.sub(line, indent_size + 1)
    if trimmed_line ~= "" then
      table.insert(result, trimmed_line)
    end
  end
  -- P(result)
  return result
end

M.send_block = function(line1, line2)
  log({ line1 = line1, line2 = line2 })
  local vSRow = line1 or vim.fn.line("v")
  local vERow = line2 or vim.api.nvim_win_get_cursor(0)[1]
  local last_line = vim.fn.line("$")
  local fold_expr = vim.wo.foldexpr
  log({ vSRow = vSRow, vERow = vERow, last_line = last_line, fold_expr = fold_expr })
  local vBlock = vim.api.nvim_buf_get_lines(0, math.max(vSRow - 1, 0), vERow, true)
  log({ vBlock = vBlock })
  vBlock = M.trim_leading_whitespace(vBlock)
  vBlock = M.trim_lines(vBlock)
  log({ vBlocknows = vBlock })
  local text = table.concat(vBlock, "\n")
  log({ block = text })
  local terms_list = nvterms.list_terms()
  if #terms_list ~= 0 then
    local current_win = api.nvim_get_current_win()
    local current_buf = api.nvim_get_current_buf()
    local term = terms_list[1]
    api.nvim_set_current_win(term.win)
    api.nvim_set_current_buf(term.buf)
    api.nvim_put(vBlock, "l", true, true)
    nvterms.send("\n")
    api.nvim_feedkeys("G", "nx", false)
    sleep(0.01)
    api.nvim_set_current_win(current_win)
    api.nvim_set_current_buf(current_buf)
  end
end


M.send_line = function()
  local terms_list = nvterms.list_terms()
  if #terms_list ~= 0 then
    local line = vim.api.nvim_get_current_line()
    line = M.trim_leading_whitespace({ line })[1]
    log(line)
    nvterms.send(line)
  end
end

return M
