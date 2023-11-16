local stdPathConfig = vim.fn.stdpath('config')

vim.g.pluginDirs = {
  vim.fn.expand(stdPathConfig .. '/pack/unmerged/opt'),
  vim.fn.expand(stdPathConfig .. '/pack/bundle/opt'),
  vim.fn.expand(stdPathConfig .. '/pack/colorscheme/opt'),
  vim.fn.expand(stdPathConfig .. '/pack/arctgx/opt'),
}
vim.g.initialVimDirectory = stdPathConfig

vim.loader.enable()

---@type NvimPlugins
local extensions = {
  {name = 'cmp-buffer'},
  {name = 'cmp-luasnip'},
  {name = 'cmp-nvim-lsp'},
  {name = 'cmp-path'},
  {name = 'nvim-cmp'},
  {name = 'comment.nvim'},
  {name = 'diffview.nvim'},
  {name = 'onedark.nvim'},
  {name = 'gitsigns.nvim'},
  {name = 'leap.nvim'},
  {name = 'lualine.nvim'},
  {name = 'luasnip'},
  {name = 'neotest'},
  {name = 'neotest-phpunit'},
  {name = 'null-ls.nvim'},
  {name = 'nvim-autopairs'},
  {name = 'nvim-bqf'},
  {name = 'nvim-dap'},
  {name = 'nvim-dap-ui'},
  {name = 'nvim-dap-tab'},
  {name = 'nvim-dap-virtual-text'},
  {name = 'nvim-lspconfig'},
  {name = 'nvim-treesitter'},
  {name = 'nvim-treesitter-context'},
  {name = 'nvim-treesitter-refactor'},
  {name = 'nvim-treesitter-textobjects'},
  {name = 'treesj'},
  {name = 'nvim-ts-context-commentstring'},
  {name = 'nvim-tree.lua'},
  {name = 'osv-dap-nvim'},
  {name = 'plenary.nvim'},
  {name = 'schemastore.nvim'},
  {name = 'telescope-fzf-native.nvim'},
  {name = 'telescope.nvim'},
  {name = 'telescope-ui-select.nvim'},
  {name = 'nui.nvim'},
  {name = 'noice.nvim'},
  {name = 'nord.nvim'},
  {name = 'phpactor'},
  {name = 'nvim-surround'},
  {name = 'statuscol.nvim'},
  {name = 'unimpaired.nvim'},
  {name = 'vim-dadbod'},
  {name = 'vim-dadbod-ui'},
  {name = 'arctgx'},
}

require('dotnvim.plugin').packadd(extensions)

local initPerHost = vim.g.initialVimDirectory .. '/initPerHost.lua'
if vim.fn.filereadable(initPerHost) == 1 then
  dofile(initPerHost)
end

vim.go.exrc = true
