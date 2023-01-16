local configDir = vim.fn.expand('<sfile>:p:h:h')

vim.env['XDG_CONFIG_HOME'] = configDir
vim.env['XDG_DATA_HOME'] = configDir .. '/.xdg/data'
vim.env['XDG_STATE_HOME'] = configDir .. '/.xdg/state'
vim.env['XDG_CACHE_HOME'] = configDir .. '/.xdg/cache'
local stdPathConfig = vim.fn.stdpath('config')

vim.opt.runtimepath:prepend(stdPathConfig)
vim.opt.packpath:prepend(stdPathConfig)
vim.opt.runtimepath:append(stdPathConfig .. '/after')

vim.g.bundle_dirs = {
     vim.fn.expand(stdPathConfig .. '/pack/unmerged/opt'),
     vim.fn.expand(stdPathConfig .. '/pack/bundle/opt'),
     vim.fn.expand(stdPathConfig .. '/pack/colorscheme/opt'),
     vim.fn.expand(stdPathConfig .. '/pack/arctgx/opt'),
}
vim.g.initialVimDirectory = stdPathConfig

local extensions = {
  {name = 'fugitive'},
  {name = 'cmp-buffer'},
  {name = 'cmp-luasnip'},
  {name = 'cmp-nvim-lsp'},
  {name = 'cmp-path'},
  {name = 'colorscheme-modus'},
  {name = 'gitsigns.nvim'},
  {name = 'leap.nvim'},
  {name = 'lualine.nvim'},
  {name = 'luasnip'},
  {name = 'null-ls.nvim'},
  {name = 'nvim-autopairs'},
  {name = 'nvim-bqf'},
  {name = 'nvim-cmp'},
  {name = 'nvim-dap'},
  {name = 'nvim-dap-ui'},
  {name = 'nvim-dap-tab'},
  {name = 'nvim-dap-virtual-text'},
  {name = 'neodev.nvim'},
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
  {name = 'surround'},
  {name = 'vim-commentary'},
  {name = 'vim-dispatch'},
  {name = 'vim-move'},
  {name = 'vim-pasta'},
  {name = 'vim-repeat'},
  {name = 'vim-rhubarb'},
  {name = 'vim-spacejam'},
  {name = 'vim-test'},
  {name = 'vim-unimpaired'},
  {name = 'vim-dadbod'},
  {name = 'vim-dadbod-ui'},
  {name = 'arctgx'},
  {name = 'impatient.nvim', bang = false},
}

for _, config in ipairs(extensions) do
  if config.bang == nil then
    bang = true
  end
  vim.cmd.packadd({args = {config.name}, bang = bang or cmd.bang})
end
require('impatient')

local initPerHost = vim.g.initialVimDirectory .. '/initPerHost.lua'
if vim.fn.filereadable(initPerHost) == 1 then
  dofile(initPerHost)
end
