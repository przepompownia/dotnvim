vim.g.pluginDirs = vim.iter({
  'arctgx',
  'plugins',
  'unmerged',
  'colorscheme',
}):map(function (group)
  return vim.fs.joinpath(vim.fn.stdpath('config'), 'pack', group, 'opt')
end):totable()

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
  {name = 'feline.nvim'},
  {name = 'luasnip'},
  {name = 'msg-show.nvim'},
  {name = 'nvim-nio'},
  {name = 'neotest'},
  {name = 'neotest-phpunit'},
  {name = 'none-ls.nvim'},
  {name = 'ultimate-autopair.nvim'},
  {name = 'nvim-bqf'},
  {name = 'nvim-dap'},
  {name = 'nvim-dap-view'},
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
  {name = 'namu.nvim'},
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
