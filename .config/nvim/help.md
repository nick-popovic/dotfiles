**Mason**

Mason is a Neovim plugin that helps manage external tools like LSP servers, linters, and formatters.

It simplifies installing and configuring language servers so the user doesn’t need to do it manually.

Some common Mason commands:
```
:Mason          – Opens the Mason UI
:MasonInstall   – Installs a specific LSP (e.g., :MasonInstall gopls)
```

**Go Setup**

nvim `:MasonInstall gopls`

- this will enable nvim to search for definitions as it's being typed i.e. ```fmt.<method-list>```

**Python Setup**

nvim `:MasonInstall pyls`

- this will enable nvim to search for definitions as it's being typed i.e. ```list.<method-list>```