local status, kanagawa = pcall(require, 'kanagawa')
if (not status) then return end

kanagawa.setup({
    commentStyle = { italic = false },
    keywordStyle = { italic = false },
});

-- Available schemes:
-- Default: kanagawa
-- kanagawa-wave
-- kanagawa-dragon
-- kanagawa-lotus
vim.cmd("colorscheme kanagawa-dragon")
