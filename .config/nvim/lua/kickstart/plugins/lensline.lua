return {
  'oribarilan/lensline.nvim',
  tag = '1.0.0', -- or: branch = 'release/1.x' for latest non-breaking updates
  event = 'LspAttach',
  config = function()
    require('lensline').setup()
  end,
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
