local M = {}

function M.OpenDefinitionInVSplit()
  local offset_encoding = (vim.lsp.get_clients({ bufnr = 0 })[1] or { offset_encoding = "utf-16" }).offset_encoding
  local params = vim.lsp.util.make_position_params(0, offset_encoding)
  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx, config)
    if err or not result or vim.tbl_isempty(result) then
      vim.notify("No definition found")
      return
    end

    local loc = vim.islist(result) and result[1] or result
    local target_uri = loc.uri or loc.targetUri
    local target_bufnr = vim.uri_to_bufnr(target_uri)

    -- Ensure the buffer is loaded
    vim.fn.bufload(target_bufnr)

    -- Check if buffer already open in any window in current tab
    local reuse_win = nil
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_buf(win) == target_bufnr then
        reuse_win = win
        break
      end
    end

    -- Only vsplit if NOT reusing a window
    if reuse_win then
      vim.api.nvim_set_current_win(reuse_win)
    else
      vim.cmd("vsplit")
      vim.api.nvim_win_set_buf(0, target_bufnr)
    end

    -- Jump to the exact location
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local offset_encoding = client and client.offset_encoding or "utf-16"
    -- Pass false for reuse_win here because we manually handled window management
    vim.lsp.util.show_document(loc, offset_encoding, { focus = true })
  end)
end

return M
