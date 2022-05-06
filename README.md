# clang-format.nvim

**Note that this plugin is just a quick POC right now. I plan to make it more configurable when I get the chance.**

```lua
require("lspconfig").clangd.setup {
  on_init = function(client)
    ...
    require("clang-format").setup(function(config, ...)
        -- Set buffer options here.
        -- "config" is the parsed output of clang-format -dump
        -- "..." are any additional arguments passed to on_attach (see below, typically client and bufnr).
    end)
  end,
  on_attach = function(client, bufnr)
    ...
    require("clang-format").on_attach(client, bufnr)
  end,
}
```

This will set the following options:

```
vim.bo.shiftwidth =: IndentWidth
vim.bo.textwidth  =: ColumnLimit
```
