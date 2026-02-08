vim.g.pluginDirs = vim.iter({
  'arctgx',
  'plugins',
  'unmerged',
  'colorscheme',
}):map(function (group)
  return vim.fs.joinpath(vim.fn.stdpath('config'), 'pack', group, 'opt')
end):totable()

for _, path in ipairs(vim.opt.packpath:get()) do
  if vim.startswith(path, '/etc/') or vim.startswith(path, '/usr/') then
    vim.opt.packpath:remove(path)
  end
end

for _, path in ipairs(vim.opt.runtimepath:get()) do
  if vim.startswith(path, '/etc/') or vim.startswith(path, '/usr/') then
    vim.opt.runtimepath:remove(path)
  end
end

vim.loader.enable()

---@type NvimPlugins
local extensions = {
  {name = 'actions-preview.nvim'},
  {name = 'nvim-snippets'},
  {name = 'diffview.nvim'},
  {name = 'onedark.nvim'},
  {name = 'gitsigns.nvim'},
  {name = 'grug-far.nvim'},
  {name = 'leap.nvim'},
  {name = 'nvim-nio'},
  {name = 'neotest-phpunit'},
  {name = 'none-ls.nvim'},
  {name = 'nvim-bqf'},
  {name = 'nvim-lspconfig'},
  {name = 'nvim-treesitter-textobjects'},
  {name = 'nvim-treesitter'},
  {name = 'nvim-treesitter-context'},
  {name = 'treesj'},
  {name = 'osv-dap-nvim'},
  {name = 'plenary.nvim'},
  {name = 'schemastore.nvim'},
  {name = 'nord.nvim'},
  {name = 'phpactor'},
  {name = 'mini.surround'},
  {name = 'statuscol.nvim'},
  {name = 'unimpaired.nvim'},
  {name = 'vim-dadbod'},
  {name = 'vim-dadbod-ui'},
  {name = 'git-utils.nvim'},
  {name = 'arctgx'},
}

-- advantage: smaller runtime
-- disadvantage: no plugin commands until package is loaded
vim.g.lazyPackaddedExtensions = {
  'namu.nvim',
  'nvim-tree.lua',
  'neotest',
  'nvim-dap',
  'nvim-dap-view',
  'nvim-dap-virtual-text',
  'nvim-dap-tab',
  'telescope-fzf-native.nvim',
  'telescope.nvim',
  'telescope-ui-select.nvim',
  'ultimate-autopair.nvim',
}

if not vim.tbl_contains({vim.fn.stdpath('config'), vim.env.NVIM_UNSANDBOXED_CONFIGDIR}, vim.uv.cwd()) then
  local exrc = vim.fs.joinpath(vim.fn.stdpath('config'), '.nvim.local.lua')
  local ok = pcall(vim.uv.fs_stat, exrc)
  if not ok then
    return
  end
  assert(loadstring(vim.secure.read(exrc) or '', 'Cannot load Lua script from ' .. exrc))()
end

require('dotnvim.plugin').packadd(extensions)

vim.go.exrc = true
