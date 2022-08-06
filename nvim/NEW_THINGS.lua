--[[

require('lspconfig').gopls.setup{
  on_attach = function()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

    vim.lsp.buf.definition
    vim.lsp.buf.type_definition          -> to wyswietli definicje czyli jak definiujmy to w interfejscie
    vim.lsp.buf.implementation           -> to wyswitli funkcje ktura impleemntuje ta definicje :)
    "n", "<leader>d" vim.diagnostic.goto_next
    "n", "<leader>pd" vim.diagnostic.goto_prev

    -- just ot have the name of the function
    -- vim.lsp.buf.rename
    -- :lua vim.lsp.buf.rename()
    -- :lua vim.lsp.buf.code_action()

  end
}

--]]
--
--
--
--sada
