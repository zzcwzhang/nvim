local packer = require('packer')
packer.startup(
function(use)
  -- Packer 可以管理自己本身
  use 'wbthomason/packer.nvim'
  -- tokyonight 皮肤
  use("folke/tokyonight.nvim")
  ---- nvim-tree 侧边目录
  use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
  -- bufferline 标签页
  use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }})
  -- lualine 下边栏
  use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
  use("arkav/lualine-lsp-progress")
  -- 文件快捷查询Ctrl + p
  use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }
  -- dashboard-nvim
  use("glepnir/dashboard-nvim")
  -- project
  use("ahmedkhalf/project.nvim")
  -- treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  --------------------- LSP --------------------
  use("williamboman/nvim-lsp-installer")
  -- Lspconfig
  use({ "neovim/nvim-lspconfig" })
end,
{
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
}
)

-- 每次保存 plugins.lua 自动安装插件
pcall(
vim.cmd,
[[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]
)
