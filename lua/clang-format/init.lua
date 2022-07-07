local function get_clang_format_config(exe)
  local f = io.popen(exe .. " --dump-config", "r")
  if f ~= nil then
    local s = f:read "*a"
    f:close()
    return s
  end
  error "[clang-format.nvim] failed to execute clang-format --dump-config"
end

local M = {}

local clang_format_config = false
local on_attach = false

M.setup = function(config)
  vim.validate {
    config = { config, "table" },
  }

  local user_on_attach = config.on_attach
    or error "[clang-format.nvim] setup(config): config must have an on_attach function"
  local exe = config.exe or "clang-format"

  if vim.fn.executable(exe) ~= 1 then
    print "could not find clang-format executable"
    return
  end

  local ok, lyaml = pcall(require, "lyaml")
  ok, lyaml = pcall(require, "yaml") -- My .so is yaml.so?
  if not ok then
    print "you must install lyaml via luarocks"
    return
  end

  clang_format_config = lyaml.load(get_clang_format_config(exe))
  on_attach = user_on_attach
end

M.on_attach = function(...)
  if clang_format_config and on_attach then
    on_attach(clang_format_config, ...)
  end
end

return M
