{pkgs, config, lib, ...}: {
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [
      neovim-remote
      lua-language-server
      rust-analyzer
      texlab
      python311Packages.python-lsp-server
      nodePackages.bash-language-server
      nil
      fzf
      ripgrep
      marksman
    ];
    programs.neovim = let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
        in {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
        viAlias = true;
        vimdiffAlias = true;
      plugins = 
      (with pkgs.vimPlugins.nvim-treesitter-parsers; [
        c cpp nix lua latex rust markdown html
      ])
      ++ 
      (with pkgs.vimPlugins; [
        diffview-nvim
        plenary-nvim
        cmp-nvim-lsp
        luasnip
        cmp_luasnip
        nvim-treesitter
        nvim-gdb
        vim-sleuth
        nui-nvim
        {
          plugin = gruvbox-nvim;
          config = toLua ''
            require("gruvbox").setup({
              overrides = {
              }
            })
            vim.cmd("colorscheme gruvbox")
          '';
        }
        {
          plugin = nvim-notify;
          config = toLua ''
            vim.notify = require("notify")
          '';
        }
        {
          plugin = noice-nvim;
          config = toLua ''
            require("noice").setup({
              lsp = {
                override = {
                  ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                  ["vim.lsp.util.stylize_markdown"] = true,
                },
              },
              presets = {
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
              },
            })
          '';
        }
        {
          plugin = telescope-nvim;
          config = toLua ''
            require('telescope').setup{
              pickers = {
                find_files = {
                  hidden = true
                }
              }
            }
          '';
        }
        {
          plugin = gitsigns-nvim;
          config = toLua ''
            require('gitsigns').setup()
          '';
        }
        {
          plugin = neoscroll-nvim;
          config = toLua ''
            require("neoscroll").setup()
          '';
        }
        {
          plugin = indent-blankline-nvim;
          config = toLua ''
            require("indent_blankline").setup{
              show_current_context = true,
              use_treesitter = true,
              char_highlight_list = {
                "NonText",
              }
            }
          '';
        }
        {
          plugin = bufferline-nvim;
          config = toLua ''
            vim.opt.termguicolors = true
            require("bufferline").setup{
              options = {
                
                numbers = function(opts)
                  return string.format("%d:", opts.id)
                end,
                diagnostics = "nvim_lsp"
              },
            }
          '';
        }
        {
          plugin = nvim-lspconfig;
          config = toLua ''
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("lspconfig").marksman.setup{
              capabilities = capabilities
            }
            require("lspconfig").html.setup{
              capabilities = capabilities
            }
            require("lspconfig").bashls.setup{
              capabilities = capabilities
            }
            require("lspconfig").nil_ls.setup{
              capabilities = capabilities
            }
            require("lspconfig").clangd.setup{
              capabilities = capabilities
            }
            require("lspconfig").lua_ls.setup{
              capabilities = capabilities
            }
            require("lspconfig").texlab.setup{
              capabilities = capabilities
            }
            require("lspconfig").rust_analyzer.setup{
              capabilities = capabilities
            }
            require("lspconfig").pylsp.setup{
              capabilities = capabilities
            }
          '';
        }
        {
          plugin = nvim-cmp;
          config = toLua ''
            local cmp = require("cmp")
            cmp.setup{
              snippet = {
                expand = function(args)
                  require("luasnip").lsp_expand(args.body)
                end
              },
              mapping = cmp.mapping.preset.insert{
                [ '<Enter>' ] = function(fallback)
                  if cmp.visible() and cmp.get_selected_entry() then
                    cmp.confirm{
                      behavior = cmp.ConfirmBehavior.Replace,
                      select = false
                    }
                  else
                    fallback()
                  end
                end,
                [ '<Tab>' ] = function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                  else
                    fallback()
                  end
                end,
                [ '<S-Tab>' ] = function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                  else
                    fallback()
                  end
                end,
              },
              sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" }
              },
              experimental = {
                ghost_text = true,
              },
            }
          '';
        }
        {
          plugin = neogit;
          config = toLua ''
            require("neogit").setup()
          '';
        }
        {
          plugin = which-key-nvim;
          config = toLua ''
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            local wk = require('which-key')
            wk.setup()
            wk.register({
              f = {name = "Find"},
            }, {prefix = "<leader>"})
          '';
        }
        {
          plugin = autosave-nvim;
          config = toLua ''
            local filters = require('autosave.filters')
            require('autosave').setup({
              plugin = {
                force = false, -- Whether to forcefully write or not (:w!)
              },
              events = {
                register = true, -- Should autosave register its autocommands
                triggers = { -- The autocommands to register, if enabled
                  'InsertLeave', 'TextChanged'
                }
              },
              debounce = {
                enabled = true, -- Should debouncing be enabled
                delay = 250 -- If enabled, only save the file at most every `delay` ms
              },
              filters = { -- The filters to apply, see above for all options.
                -- These filters are required for basic operation as they prevent
                -- errors related to to buffer state.
                filters.writeable,
                filters.not_empty,
                filters.modified,
              }
            })
          '';
        }
        {
          plugin = tmux-nvim;
          config = toLua ''
            require('tmux').setup()
          '';
        }
      ]);
      extraLuaConfig = ''
        vim.wo.number = true
        vim.wo.relativenumber = true
        vim.wo.wrap = false
        vim.opt.cursorline = true
        local map = vim.keymap.set
        map('n', '<Tab>',
          ':bn<cr>',
          { silent = true, desc = 'Next Buffer' }
        )
        map('n', '<S-Tab>',
          ':bp<cr>',
          { silent = true, desc = 'Previous Buffer' }
        )
        local map = vim.keymap.set
        local telescope_builtin = require('telescope.builtin')
        vim.g.mapleader = ' '

        map('n', '<leader>fb',
          telescope_builtin.buffers,
          { silent = true, desc = 'Find Buffers' }
        )
        map('n', '<leader>fs',
          telescope_builtin.live_grep,
          { silent = true, desc = 'Find String' }
        )
        map('n', '<leader>ff',
          telescope_builtin.find_files,
          { silent = true, desc = 'Find Files' }
        )
        map('n', '<leader>hk',
          telescope_builtin.keymaps,
          { silent = true, desc = 'Help Keymaps' }
        )
        map('n', '<leader>hc',
          telescope_builtin.keymaps,
          { silent = true, desc = 'Help Tags' }
        )
      '';
    };
  };
}
