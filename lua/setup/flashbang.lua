return {
  'NullSeile/flashbang.nvim',
  config = function()
    require('flashbang').setup {
      min_interval = 5,
      max_interval = 20,
      duration = 2.5,
    }
  end,
}
