local M = {}

-- Define the function to read text from a file
local function get_content()
    return [[
== Movement to letter ==
    f [letter] - Move to letter 
    t [letter] - Move up to letter 
    ct [letter] - Change until letter

== Spell check ==
    :set spell – Turn on spell checking
    :set nospell – Turn off spell checking
    ]s – Jump to the next misspelled word
    [s – Jump to the previous misspelled word
    z= – Bring up the suggested replacements
    zg – Good word: Add the word under the cursor to the dictionary
    zw – Woops! Undo and remove the word from the dictionary

== Movement ==
    CTRL + [fbdu] - Fast scroll
    g [jk] - Move in wrapped text

== Split Panes ==
    CTRL + w [hjkl] - Navigate    
    CTRL + w [vs] - Split    
    CTRL + w [<>] - Chhange Width
    CTRL + w [+-=] - Change Height
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

