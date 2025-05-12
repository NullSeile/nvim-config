return {
  {
    'kwkarlwang/bufresize.nvim',
    config = function()
      require('bufresize').setup {
        resize = {
          trigger_events = { 'VimResized' },
        },
      }
    end,
  },
  {
    'mrjones2014/smart-splits.nvim',
    build = './kitty/install-kittens.bash',
    lazy = false,
    config = function()
      require('smart-splits').setup {
        -- multiplexer_integration = 'tmux',
        -- at_edge = 'stop',
        at_edge = 'wrap',
      }

      -- vim.keymap.set('n', '<C-S-y>', require('smart-splits').resize_left)
      -- vim.keymap.set('n', '<C-S-u>', require('smart-splits').resize_down)
      -- vim.keymap.set('n', '<C-S-i>', require('smart-splits').resize_up)
      -- vim.keymap.set('n', '<C-S-o>', require('smart-splits').resize_right)

      vim.keymap.set('n', '<C-S-y>', require('smart-splits').resize_left)
      vim.keymap.set('n', '<C-S-u>', require('smart-splits').resize_down)
      vim.keymap.set('n', '<C-S-i>', require('smart-splits').resize_up)
      vim.keymap.set('n', '<C-S-o>', require('smart-splits').resize_right)

      -- moving between splits
      vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
      vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
      vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
      vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
      -- vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)

      -- swapping buffers between windows
      vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
      vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
      vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
      vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
    end,
  },
  -- {
  --   'numToStr/Navigator.nvim',
  --   config = function()
  --     require('Navigator').setup {
  --       auto_save = nil,
  --       disable_on_zoom = false,
  --       mux = 'auto',
  --     }
  --
  --     vim.keymap.set({ 'n', 't' }, '<C-h>', '<CMD>NavigatorLeft<CR>')
  --     vim.keymap.set({ 'n', 't' }, '<C-l>', '<CMD>NavigatorRight<CR>')
  --     vim.keymap.set({ 'n', 't' }, '<C-k>', '<CMD>NavigatorUp<CR>')
  --     vim.keymap.set({ 'n', 't' }, '<C-j>', '<CMD>NavigatorDown<CR>')
  --     vim.keymap.set({ 'n', 't' }, '<C-p>', '<CMD>NavigatorPrevious<CR>')
  --   end,
  -- },
}
