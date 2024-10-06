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

My `nvterm` config:

```lua
  {
    "NvChad/nvterm",
    keys = {
      {
        "<localleader>th",
        function()
          require("nvterm.terminal").toggle("horizontal")
        end,
        mode = "n",
        desc = "Toggle h-term",
      },
      {
        "<localleader>tv",
        function()
          -- require("nvterm.terminal").new("vertical")
          require("nvterm.terminal").toggle("vertical")
        end,
        mode = "n",
        desc = "Toggle v-term",
      },
    },

    config = function()
      require("nvterm").setup({})
    end,
  },
```

## Usage:

Open a nvterm buffer using `<localleader>tv`, then open python inside it. Go
back to the original buffer. Select the code line and then `<localleader>sl` or
in normal mode `<leader>ss` to send the current line.

**Important** this behaves like copy-pasting a block to python REPL, so the same
errors you'd get when you copy-paste something like the following will persist:

```python
for i in range(10):
    print(i)
print("Done!")
```
