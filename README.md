# clang-format.nvim

**Note that this plugin is just a quick POC right now. I plan to make it more configurable when I get the chance.**

```lua
require("lspconfig").clangd.setup {
  on_init = function(client)
    ...
    require("clang-format").setup {}
  end,
  on_attach = function(client, bufnr)
    ...
    -- NOTE: This currently only sets vim.bo.shiftwidth based on IndentWidth from clang-format
    require("clang-format").on_attach(client, bufnr)
  end,
}
```
