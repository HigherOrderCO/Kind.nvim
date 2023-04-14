# kind.nvim

Kind Neovim plugin.

```lua
-- it's required to have the treesitter plugin
local treesitter_config = require("nvim-treesitter.configs")
treesitter_config.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}

-- setup kind c:
require("kind").setup()
```
