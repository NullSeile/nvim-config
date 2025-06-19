return {
  'chomosuke/typst-preview.nvim',
  dependencies = {
    'windwp/nvim-autopairs',
  },
  lazy = false, -- or ft = 'typst'
  version = '1.*',
  config = function()
    require('typst-preview').setup {
      invert_colors = 'always',
    }

    local npairs = require 'nvim-autopairs'
    local Rule = require 'nvim-autopairs.rule'

    npairs.add_rules {
      Rule('$', '$', 'typst'),
      Rule('$ ', ' ', 'typst'),
    }
  end,
}
