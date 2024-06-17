local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    }
  },
}

M.trouble = {
  -- plugin = true,
  n = {
    ["<leader>tt"] = {
      "<cmd> TroubleToggle <CR>",
      "Toggle trouble",
    }
  },
}

return M
