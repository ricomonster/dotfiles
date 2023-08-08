local opt = vim.opt

-- Indenting
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
  end,
})
