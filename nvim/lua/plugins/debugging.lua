return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Nice debugger UI
      "rcarriga/nvim-dap-ui",

      -- Debugger support in Mason.nvim
      -- "williamboman/mason.nvim",
      -- "jay-babu/mason-nvim-dap.nvim",

      -- Shows variable values inline as virtual text
      "theHamsta/nvim-dap-virtual-text",

      -- Asynchronous IO
      "nvim-neotest/nvim-nio",
    },
    ---@module 'lazy'
    ---@type LazyKeysSpec[]
    keys = {
      {
        "<leader>b",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Toggle Breakpoint",
      },
      -- Breakpoints
      {
        "<leader>b",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Toggle Breakpoint",
      },
      {
        "<leader>B",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Debug: Set Breakpoint",
      },
      -- Misc
      {
        "<leader>gb",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Debug: Run to cursor",
      },
      {
        "<leader>?",
        function()
          require("dapui").eval(nil, { enter = true })
        end,
        desc = "Debug: Eval under cursor",
      },
      -- Debugger controls
      {
        "<F1>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },
      {
        "<F2>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },
      {
        "<F3>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: Step Out",
      },
      {
        "<F4>",
        function()
          require("dap").step_back()
        end,
        desc = "Debug: Step Back",
      },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Start/Continue",
      },
      {
        "<F6>",
        function()
          require("dap").restart()
        end,
        desc = "Debug: Restart",
      },
      -- Toggle to see last session result.
      -- Without this, you can't see session output in case of unhandled exception.
      {
        "<F7>",
        function()
          require("dapui").toggle()
        end,
        desc = "Debug: See last session result.",
      },
      {
        "<F8>",
        function()
          require("dap").stop()
        end,
        desc = "Debug: Stop",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        controls = {
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "b",
            run_last = "▶▶",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      })

      require("nvim-dap-virtual-text").setup({})

      ---@module 'dap'
      ---@type dap.Adapter
      dap.adapters.lldb = {
        type = "executable",
        command = "lldb",
        name = "lldb",
      }

      ---@module 'dap'
      ---@type dap.Adapter
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        name = "gdb",
      }

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close
    end,
  },
  {
    "julianolf/nvim-dap-lldb",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {},
  },
}
