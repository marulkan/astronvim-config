--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}

    vim.filetype.add({
      extension = {
        j2 = "jinja",
      },
    })

    vim.list_extend(opts.ensure_installed, { "yaml", "jinja" })

    opts.highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    }

    opts.indent = {
      enable = true,
    }

    opts.additional_vim_regex_highlighting = false

    -- vim.api.nvim_set_hl(0, "@punctuation.bracket.yaml", { link = "@jinja" })
    -- vim.api.nvim_set_hl(0, "@jinja", { link = "Function" })
    -- vim.api.nvim_set_hl(0, "@jinja.block", { link = "Keyword" })
    -- vim.api.nvim_set_hl(0, "@jinja.variable", { link = "Identifier" })

    return opts
  end,
}
