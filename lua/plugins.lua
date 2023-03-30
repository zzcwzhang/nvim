local packer = require('packer')
packer.startup(
  function(use)
    -- emmet
    use 'mattn/emmet-vim'
    -- styled-components
    use 'styled-components/vim-styled-components'
    -- GIT
    use 'tpope/vim-fugitive'
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'
    -- tokyonight 皮肤
    use("folke/tokyonight.nvim")
    ---- nvim-tree 侧边目录
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
    -- bufferline 标签页
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })
    -- lualine 下边栏
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
    use("arkav/lualine-lsp-progress")
    -- 文件快捷查询Ctrl + p
    use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }
    -- project
    use("ahmedkhalf/project.nvim")
    -- treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    --------------------- LSP --------------------
    use "williamboman/mason.nvim"
    -- Lspconfig
    use({ "neovim/nvim-lspconfig" })
    -- 补全引擎
    use("hrsh7th/nvim-cmp")
    -- snippet 引擎
    use("hrsh7th/vim-vsnip")
    -- 包围
    use({
      "kylechui/nvim-surround",
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end
    })
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
    -- 常见编程语言代码段
    use("rafamadriz/friendly-snippets")
    -- 代码补全
    use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
    -- 常用图标
    use("onsails/lspkind-nvim")
    -- 括号匹配
    use {
      "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
    }
    -- GPTUI
    use "MunifTanjim/nui.nvim"
    -- 注释
    use "terrortylor/nvim-comment"
    -- GPT
--     use({
--       "zzcwzhang/ChatGPT.nvim",
--       config = function()
--       require("chatgpt").setup({
--         -- optional configuration
--       })
--     end,
--     requires = {
--       "MunifTanjim/nui.nvim",
--       "nvim-lua/plenary.nvim",
--       "nvim-telescope/telescope.nvim"
--     }
-- })
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
-- pcall(
--   vim.cmd,
--   [[
-- augroup packer_user_config
-- autocmd!
-- autocmd BufWritePost plugins.lua source <afile> | PackerSync
-- augroup end
-- ]]
-- )
