-- Set up lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("core.options")          -- Load core configurations
require("lazy").setup("plugins") -- Load plugins

-- Function to completely reload the entire configuratn
function _G.ReloadConfig()
    -- Clear the cache for all modules under your config namespaces
    for name, _ in pairs(package.loaded) do
        if name:match('^core') or name:match('^plugins') then
            package.loaded[name] = nil
        end
    end

    -- Source the main configuration file again
    dofile(vim.fn.stdpath('config') .. '/init.lua')

    -- Notify the user
    vim.notify('Nvim configuration completely reloaded!', vim.log.levels.INFO)
end

-- Keymap to trigger the full reload
vim.api.nvim_set_keymap('n', '<leader>r', '<cmd>lua ReloadConfig()<CR>', { noremap = true, silent = true, desc = "Reload entire config" })
