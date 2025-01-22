require'nvim-treesitter.configs'.setup {
  ensure_installed = {"python"},  -- Ensure the Python parser is installed
  highlight = {
    enable = true,                -- Enable highlighting
    additional_vim_regex_highlighting = false,  -- Turn off regex-based highlighting
  },
}

