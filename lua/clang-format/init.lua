local function get_clang_format_config()
  local f = io.popen("clang-format --dump-config", "r")
  local s = f:read "*a"
  f:close()
  return s
end

local M = {}

local config = false

M.setup = function(opts)
  if vim.fn.executable "clang-format" ~= 1 then
    print "could not find clang-format executable"
    return
  end

  local ok, lyaml = pcall(require, "lyaml")
  if not ok then
    print "you must install lyaml via luarocks"
    return
  end

  config = lyaml.load(get_clang_format_config())
end

M.on_attach = function(...)
  if config then
    vim.bo.shiftwidth = config.IndentWidth
    vim.bo.textwidth = config.ColumnLimit
  end
end

return M
