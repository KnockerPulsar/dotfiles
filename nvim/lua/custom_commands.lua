local vim = vim

local custom_commands = {
	['Cfg'] = 'edit ~/.config/nvim/init.lua',
	['Cmd'] = 'edit ~/.config/nvim/lua/custom_commands.lua',
	['Plg'] = 'edit ~/.config/nvim/lua/plugins.lua',
	['Lsp'] = 'edit ~/.config/nvim/lua/lsp_init.lua',
	['Keys'] ='edit ~/.config/nvim/lua/keymaps.lua',
	['Packer'] ='edit ~/.config/nvim/lua/packer_init.lua',
	['NextError'] ='lua vim.diagnostic.goto_next()',
	['PrevError'] ='lua vim.diagnostic.goto_prev()',
}

for word, command in pairs(custom_commands) do
	vim.api.nvim_create_user_command(word, command,  {})
end

local function preview_location_callback(_, method, result)
  if result == nil or vim.tbl_isempty(result) then
    vim.lsp.log.info(method, 'No location found')
    return nil
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.preview_location(result[1])
  else
    vim.lsp.util.preview_location(result)
  end
end

function peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

vim.api.nvim_create_user_command("PeekDef", peek_definition,  {})
