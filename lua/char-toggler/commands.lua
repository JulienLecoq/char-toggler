local api = vim.api
local M = {}

-- local function string_contains(str, str_to_find)
--     return string.find(str, str_to_find) ~= nil
-- end
--
local function replace_str(str, replacement_str, start_index, end_index)
    return str:sub(1, start_index - 1) .. replacement_str .. str:sub(end_index + 1)
end

local function toggle_tab()
    if vim.o.list == false then
        vim.o.list = true
        return
    end

    local start_index, end_index = string.find(vim.o.listchars, "tab[^,]*")

    if start_index then
        vim.o.listchars = replace_str(vim.o.listchars, "", start_index, end_index + 1)
    else
        vim.o.listchars = vim.o.listchars.. "tab:» ,"
    end
end

local function toggle_space()
    if vim.o.list == false then
        vim.o.list = true
        return
    end

    local start_index, end_index = string.find(vim.o.listchars, "space[^,]*")

    if start_index then
        vim.o.listchars = replace_str(vim.o.listchars, "", start_index, end_index + 1)
    else
        vim.o.listchars = vim.o.listchars.. "space:.,"
    end
end

local function toggle_other()
    if vim.o.list == false then
        vim.o.list = true
        return
    end

    local start_index, end_index = string.find(vim.o.listchars, "conceal[^,]*")

    if start_index then
        vim.o.listchars = replace_str(vim.o.listchars, "", start_index, end_index + 1)
    else
        vim.o.listchars = vim.o.listchars.. "conceal:┊,"
    end
end

local function toggle_char()
    if vim.o.list then
        vim.o.list = false
    else
        vim.o.list = true
    end
end

local function register()
    api.nvim_create_user_command("ToggleSpace", toggle_space, {})
    api.nvim_create_user_command("ToggleTab", toggle_tab, {})
    api.nvim_create_user_command("ToggleOther", toggle_other, {})
    api.nvim_create_user_command("ToggleChar", toggle_char, {})
end

function M.setup()
    register()
end

return M
