## Send code snippets to Python REPL inside NvChad/nvterm


Send code snippets to a python REPL in NvTerm buffer. Requires `NvChad/nvterm"`.

Provided as is.

```lua

    {
    "ayghri/nvpython.nvim",
    -- dev = true,
    dependencies = {
      "NvChad/nvterm",
    },
    config = function()
      require("nvpython").setup({})
    end,
    keys = {
      { "<leader>ss", ":SendBlock<CR>", mode = "v", desc = "Send Selection" },
      { "<localleader>sl", ":SendLine<CR>", mode = "n", desc = "Send line" },
    },
  }

```
