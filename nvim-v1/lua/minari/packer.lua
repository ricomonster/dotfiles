-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

    -- Telescope
    use {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

    -- Color Scheme
	use({ 'rebelot/kanagawa.nvim', as = 'kanagawa' })

    -- Per-language setup
    use 'ray-x/go.nvim'

	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use('nvim-treesitter/playground')
	use('theprimeagen/harpoon')

    -- LSP Setup
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
			'williamboman/mason.nvim',
			run = function()
				pcall(vim.cmd, 'MasonUpdate')
			end,
		},
		{'williamboman/mason-lspconfig.nvim'}, -- Optional

		-- Autocompletion
		{'hrsh7th/nvim-cmp'},
		{'hrsh7th/cmp-nvim-lsp'},
		{'hrsh7th/cmp-path'},

        -- snippets
        {"L3MON4D3/LuaSnip"}, -- snippet engine
        {"saadparwaiz1/cmp_luasnip"}, -- for autocompletion
        {"rafamadriz/friendly-snippets"}, -- useful snippets
	};
    use("onsails/lspkind.nvim"); -- vs-code like icons for autocompletion

    -- File Explorer
    use('nvim-tree/nvim-tree.lua');

    -- nvim-tree file icons
    use('nvim-tree/nvim-web-devicons');

    -- Status Line
    use('nvim-lualine/lualine.nvim');

    -- Window/UI Management
    use("christoomey/vim-tmux-navigator"); -- tmux & split window navigation
    use("szw/vim-maximizer"); -- maximizes and restores current window

    -- formatting & linting
    use("jose-elias-alvarez/null-ls.nvim"); -- configure formatters & linters
    use("jayp0521/mason-null-ls.nvim"); -- bridges gap b/w mason & null-ls

    -- git integration
    use("lewis6991/gitsigns.nvim")
}
end)
