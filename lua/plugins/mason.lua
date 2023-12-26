return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "stylua",
      "eslint-lsp",
      "json-lsp",
      "lua-language-server",
      "prettier",
      "shfmt",
      "tailwindcss-language-server",
      "typescript-language-server",
      "vue-language-server",
    })
  end,
}
