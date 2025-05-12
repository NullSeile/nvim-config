return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    { 'kmonad/kmonad-vim', fmt = 'kdb' },
    { 'maelvalais/gmpl.vim' },
  },
  build = ':TSUpdate',
  config = function()
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    if vim.fn.has 'win32' == 1 then
      require('nvim-treesitter.install').compilers = { 'zig' }
    end
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup { -- Sets main module to use for opts
      ensure_installed = { 'gitcommit', 'bash', 'diff' },
      -- ensure_installed = { 'bash', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      additional_vim_regex_highlighting = true,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      rainbow = { enable = true },
    }
  end,
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
