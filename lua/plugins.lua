-- Bootstrap Packer
local fn = vim .fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Add plugins
local f =  require'packer'.startup(function(use)
  use 'wbthomason/packer.nvim'

  --use 'airblade/vim-gitgutter'
  use { 'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
      -- {
      --   signs = {
      --     add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
      --     change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      --     delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      --     topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      --     changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      --   },
      --   numhl = false,
      --   linehl = false,
      --   keymaps = {
      --     -- Default keymap options
      --     noremap = true,
      --     buffer = true,
      --
      --     ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
      --     ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},
      --
      --     ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      --     ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      --     ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      --     ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
      --     ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      --     ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
      --
      --     -- Text objects
      --     ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
      --     ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
      --   },
      --   watch_index = {
      --     interval = 1000
      --   },
      --   current_line_blame = false,
      --   sign_priority = 6,
      --   update_debounce = 100,
      --   status_formatter = nil, -- Use default
      --   use_decoration_api = true,
      --   use_internal_diff = true,  -- If luajit is present
      -- }
    end
  }

  use { 'preservim/nerdcommenter',
    config = function()
      vim.g.NERDCompactSexyComs = true
      vim.g.NERDSpaceDelims = true
      vim.g.NERDCommentEmptyLines = true
      vim.g.NERDDefaultAlign = 'left'
      vim.g.NERDTrimTrailingWhitespace = true
    end
  }

  use 'jiangmiao/auto-pairs'

  use{ 'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_style = 'storm'
      vim.g.tokyonight_italic_functions = true
      vim.g.tokyonight_italic_variables = true
      vim.g.tokyonight_sidebars = { 'nerdtree', 'packer' }
      vim.cmd "colorscheme tokyonight"
    end
  }

  use { 'hoob3rt/lualine.nvim',
    requires = { {'kyazdani42/nvim-web-devicons', opt = false}, {'ryanoasis/vim-devicons', opt = false} },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'tokyonight',
          section_separators = {'', ''},
          component_separators = {'', ''},
          -- section_separators = {' ', '  '},
          -- component_separators = {' ', ' '},
          icons_enabled = true,
        },
        sections = {
        lualine_a = { {'mode', upper = true} },
        lualine_b = { {'branch', icon = ''} },
        lualine_c = { {'filename', file_status = true, symbols = {modified = '  ', readonly = '  ' }} },
        lualine_x = { {
            'diagnostics',
            sources = { 'ale', 'nvim_lsp' },
            symbols = {
              error = ' ﮊ ',
              warn =  ' ﮻ ',
              info = '  '
            }
          } },
        lualine_y = { 'progress' },
        lualine_z = { 'location'  },
      },
      inactive_sections = {
        lualine_a = {  },
        lualine_b = {  },
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {  },
        lualine_z = {   }
      },
      tabline = {
        lualine_a = {  },
        lualine_b = {  },
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {  },
        lualine_z = {   }
      },
      extensions = { 'fugitive', 'nerdtree' }
      }
    end
  }

  use { 'dense-analysis/ale',
    opt = false,
    setup = function()
      -- Called before plugin loaded
    end,
    config = function()
      -- Called after plugin loaded
      vim.g.ale_lua_luacheck_options = '--globals vim'
      vim.g.ale_detail_to_floating_preview = true
      vim.g.ale_floating_preview = true
      vim.g.ale_sign_error = 'ﮊ'
      vim.g.ale_sign_warning ='﮻'
      vim.g.ale_sign_info = ''
    end
  }

  use { 'preservim/nerdtree',
    requires = {
      {'ryanoasis/vim-devicons', opt = false},
      {'Xuyuanp/nerdtree-git-plugin', opt = false}
    },
    config = function()
      vim.cmd[[let mapleader=" "]]
      require('map')('n', '<Leader>n', ':NERDTreeToggle<CR>', {silent = true})
    end
  }

  use 'tpope/vim-fugitive'

  use 'tpope/vim-git'

  use 'tpope/vim-sensible'

  use 'tpope/vim-surround'

  use 'fhill2/floating.nvim'

  use 'jeffkreeftmeijer/vim-numbertoggle'

  use 'sheerun/vim-polyglot'

  use { 'Yggdroot/indentLine',
    config = function()
      vim.g.indentLine_setColors = true
      vim.g.indentLine_char = ''
    end
  }

  use 'lukas-reineke/indent-blankline.nvim'

  use { 'nvim-treesitter/nvim-treesitter',
    opt = false,
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = { enabled = true },
        incremental_selection = { enabled = true },
        indent = { enabled = true }
      }
    end
  }
end)

return f
