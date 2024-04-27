local M = {}

-- Define the function to read text from a file
local function get_content()
    return [[
=== Scroll ===
CTRL + [fbdu]

=== Split Panes ===
Navigate: CTRL + w [hjkl]
Split: CTRL + w [vs]
Width: CTRL + w [<>]
Height: CTRL + w [+-=]
]]
end


-- Function to create and display the popup
function M.show_popup()
    -- Predefined scrollable text
    local text = get_content()

    -- Calculate the width and height of the popup
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)

    -- Create a buffer for the popup
    local buf = vim.api.nvim_create_buf(false, true)

    -- Set buffer lines from the text table
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, '\n'))

    -- Define the popup window options
    local opts = {
        relative = 'editor',
        width = width,
        height = height,
        col = vim.o.columns * 0.1,
        row = vim.o.lines * 0.1,
        anchor = 'NW',
        style = 'minimal',
        border = 'rounded'
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Enable scrolling
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    vim.api.nvim_win_set_option(win, 'cursorline', true)  -- Highlight the current line
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<Cmd>lua vim.api.nvim_win_close(' .. win .. ', true)<CR>', { noremap = true, silent = true })

    return win
end

-- Command registration
vim.api.nvim_create_user_command('CheatSheet', M.show_popup, {})

-- Default shortcut to open the popup
-- vim.api.nvim_set_keymap('n', '<Leader>c', ':CheatSheet<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'g?', ':CheatSheet<CR>', { noremap = true, silent = true })

return M

