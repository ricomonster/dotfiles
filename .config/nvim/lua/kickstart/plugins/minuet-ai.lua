return {
  'milanglacier/minuet-ai.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('minuet').setup {
      provider = 'openai_compatible',
      request_timeout = 2.5,
      throttle = 1500, -- Increase to reduce costs and avoid rate limits
      debounce = 600, -- Increase to reduce costs and avoid rate limits
      provider_options = {
        openai_compatible = {
          api_key = 'OPENCODE_GO_API_KEY',
          end_point = 'https://opencode.ai/zen/go/v1/chat/completions',
          model = 'deepseek-v4-flash',
          name = 'Opencode',
          optional = {
            max_tokens = 56,
            top_p = 0.9,
            -- disable thinking to avoid first token latency
            thinking = { type = 'disabled' },
          },
        },
      },
    }
  end,
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
