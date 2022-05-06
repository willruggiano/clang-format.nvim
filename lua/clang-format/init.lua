local function get_clang_format_config()
  local f = io.popen("clang-format --dump-config", "r")
  local s = f:read "*a"
  f:close()
  return s
end

local M = {}

local config = false
local on_attach = false

M.setup = function(f_on_attach)
  vim.validate {
    func = { f_on_attach, "function", "setup() accepts a single, required argument which must be a function" },
  }

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
  on_attach = f_on_attach
end

M.on_attach = function(...)
  if config then
    on_attach(config, ...)
  end
end

return M
