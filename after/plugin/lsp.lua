local lsp = require("lsp-zero")

lsp.preset("recommended")


-- Make sure ruby gem is installed 
require("mason").setup()
require("mason-lspconfig").setup {
    automatic_installation = true,
    ensure_installed = {
        "lua_ls", "rust_analyzer", "tsserver", "clangd", "neocmake",
        "cssls", "html", "gopls", "helm_ls", "jqls", "marksman", "ruby_lsp",
        "pyright", "sqlls", "tflint", "yamlls", "lemminx",
        "zls", "taplo", "jdtls", "grammarly", "graphql", "bashls", "ansiblels"},
}



local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<M-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<M-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<M-y>'] = cmp.mapping.confirm({ select = true }),
  ["<M-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-l>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

