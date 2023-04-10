local packer = require('packer')
packer.startup(
  function(use)
    -- dashboard
    use {
      'glepnir/dashboard-nvim',
      event = 'VimEnter',
      requires = {'nvim-tree/nvim-web-devicons'}
    }
    -- emmet
    use 'mattn/emmet-vim'
    -- styled-components
    use 'styled-components/vim-styled-components'
    -- css color
    use 'ap/vim-css-color'
    -- GIT 支持大写Gread等等
    use 'tpope/vim-fugitive'
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'
    -- tokyonight 皮肤
    use "folke/tokyonight.nvim"
    -- icon
    use "kyazdani42/nvim-web-devicons"
    ---- nvim-tree 侧边目录 g? 可以打开提示
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
    -- bufferline 标签页上的状态
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })
    -- lualine 下边栏
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
    use("arkav/lualine-lsp-progress")
    -- 文件快捷查询p
    use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }
    use {
      "nvim-telescope/telescope-file-browser.nvim",
      requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }
    use { "nvim-telescope/telescope-file-browser.nvim", }
    use { "nvim-telescope/telescope-project.nvim", }
    -- project <leader>fp
    -- use("ahmedkhalf/project.nvim")
    -- treesitter 语法高亮
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    --------------------- LSP --------------------
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    -- Lspconfig
    use({ "neovim/nvim-lspconfig" })

    -- Installation
    -- snippet 引擎
    use({
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      tag = "v<CurrentMajor>.*",
      -- install jsregexp (optional!:).
      run = "make install_jsregexp"
    })
    -- 代码补全引擎
    use { 'hrsh7th/nvim-cmp' }
    use { 'saadparwaiz1/cmp_luasnip' }
    -- 补全源
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
    -- trouble
    use {
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
    }
    -- 代码补全
    use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
    -- 常用图标
    use("onsails/lspkind-nvim")
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
    -- 括号匹配
    use {
      "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
    }
    -- GPTUI
    use "MunifTanjim/nui.nvim"
    -- 注释 使用gcc注释
    use "terrortylor/nvim-comment"

    -- 支持jsx注释
    use 'JoosepAlviste/nvim-ts-context-commentstring'
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
