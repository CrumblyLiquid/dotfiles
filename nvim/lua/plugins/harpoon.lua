return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    vim.keymap.set("n", "<leader>ka", function()
      harpoon:list():add()
      print("Added buffer to Harpoon list")
    end, { desc = "Add buffer to Harpoon" })

    vim.keymap.set("n", "<leader>kr", function()
      harpoon:list():remove()
      print("Removed buffer from Harpoon list")
    end, { desc = "Remove buffer from Harpoon" })

    vim.keymap.set("n", "<leader>j", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Open Harpoon window" })

    vim.keymap.set("n", "<leader>kj", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open Harpoon window" })

    --[[ vim.keymap.set("n", "<C-j>", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<C-k>", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<C-l>", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<C-;>", function()
      harpoon:list():select(4)
    end) ]]

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function()
      harpoon:list():prev()
    end)
    vim.keymap.set("n", "<C-S-N>", function()
      harpoon:list():next()
    end)

    -- Set <space>1..<space>9 be my shortcuts to moving to the files
    for _, idx in ipairs({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }) do
      vim.keymap.set("n", string.format("<space>%d", idx), function()
        harpoon:list():select(idx)
      end, { desc = "Harpoon" })
    end
  end,
}
