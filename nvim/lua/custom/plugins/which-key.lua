return {
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      local which = require("which-key")
      which.setup()
      which.register({
        ["<leader>c"] = { name = "[C] Code", _ = "which_key_ignore" },
        ["<leader>d"] = { name = "[D] Document", _ = "which_key_ignore" },
        ["<leader>r"] = { name = "[R] Rename", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "[S] Search", _ = "which_key_ignore" },
        ["<leader>f"] = { name = "[F] Files", _ = "which_key_ignore" },
        ["<leader>k"] = { name = "[K] Harpoon", _ = "which_key_ignore" },
      })
    end,
  },
}
