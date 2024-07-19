vim.g.pluginDirs = vim.iter({
  'unmerged',
  'bundle',
  'arctgx',
  'colorscheme',
}):map(function (group)
  ---@diagnostic disable-next-line: param-type-mismatch
  return vim.fs.joinpath(vim.fn.stdpath('config'), 'pack', group, 'opt')
end):totable()

vim.loader.enable()

---@type NvimPlugins
local extensions = {
  {name = 'actions-preview.nvim'},
  {name = 'cmp-buffer'},
  {name = 'cmp-luasnip'},
  {name = 'cmp-nvim-lsp'},
  {name = 'cmp-path'},
  {name = 'nvim-cmp'},
  {name = 'diffview.nvim'},
  {name = 'onedark.nvim'},
  {name = 'gitsigns.nvim'},
  {name = 'leap.nvim'},
  {name = 'lualine.nvim'},
  {name = 'luasnip'},
  {name = 'nvim-nio'},
  {name = 'neotest'},
  {name = 'neotest-phpunit'},
  {name = 'none-ls.nvim'},
  {name = 'nvim-autopairs'},
  {name = 'nvim-bqf'},
  {name = 'nvim-dap'},
  {name = 'nvim-dap-ui'},
  {name = 'nvim-dap-tab'},
  {name = 'nvim-dap-virtual-text'},
  {name = 'nvim-lspconfig'},
  {name = 'nvim-treesitter-textobjects'},
  {name = 'nvim-treesitter'},
  {name = 'nvim-treesitter-context'},
  {name = 'treesj'},
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
  {name = 'git-utils.nvim'},
  {name = 'arctgx'},
}

require('dotnvim.plugin').packadd(extensions)

if not vim.tbl_contains({vim.fn.stdpath('config'), vim.env.NVIM_UNSANDBOXED_CONFIGDIR}, vim.uv.cwd()) then
  local exrc = vim.fs.joinpath(vim.fn.stdpath('config'), '.nvim.lua')
  local ok = pcall(vim.uv.fs_stat, exrc)
  if not ok then
    return
  end
  assert(loadstring(vim.secure.read(exrc) or '', 'Cannot load Lua script from ' .. exrc))()
end

vim.go.exrc = true
