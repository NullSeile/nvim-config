-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<C-S-a>', 'ggVG', { desc = 'Select all' })
vim.keymap.set('n', '<A-o>', 'o<Esc>', { desc = 'Insert a new line below the cursor' })
vim.keymap.set('n', '<A-O>', 'O<Esc>', { desc = 'Insert a new line above the cursor' })

-- https://seblog.nl/2024/01/28/1/toggling-in-vim-with-unimpaired
vim.keymap.set('n', '<leader>tc', ':Copilot <C-R>=copilot#Enabled() ? "disable" : "enable"<CR><CR>', { desc = 'Toggle [C]opilot' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
