local M = {}

-- function M.OpenDefinitionInVSplit()
--   vim.lsp.buf_request(0, "textDocument/definition", vim.lsp.util.make_position_params(), function(_, result)
--     if not result or vim.tbl_isempty(result) then
--       return
--     end
--
--     local loc = result[1]
--     local target_uri = loc.uri or loc.targetUri
--     local target_bufnr = vim.uri_to_bufnr(target_uri)
--
--     -- Check if buffer already open in any window
--     local reuse_win
--     for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
--       if vim.api.nvim_win_get_buf(win) == target_bufnr then
--         reuse_win = win
--         break
--       end
--     end
--
--     vim.cmd("vsplit")
--
--     if reuse_win then
--       vim.api.nvim_set_current_win(reuse_win)
--     else
--       vim.lsp.util.jump_to_location(loc, "utf-8", true)
--     end
--   end)
-- end

return M
