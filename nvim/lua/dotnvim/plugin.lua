local Plugin = {}

---@alias NvimPlugins {name: string, bang: boolean}[]

---@param extensions NvimPlugins
function Plugin.packadd(extensions)
  for _, config in ipairs(extensions) do
    local bang = true
    if config.bang ~= nil then
      bang = config.bang
    end
    local ok, error = pcall(vim.cmd.packadd, {
      args = {config.name},
      bang = bang,
    })
    if not ok then
      vim.api.nvim_create_autocmd('UIEnter', {
        once = true,
        callback = function ()
          vim.notify(error, vim.log.levels.ERROR)
        end,
      })
    end
  end
end

return Plugin
