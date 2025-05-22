{pkgs, ...}:
{
  imports = [
  ];
  plugins = {
    auto-save = {
      enable = true;
    };
    bufferline = {
      enable = true;
      diagnostics = "nvim_lsp";
      separatorStyle = "slant";
    };
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          {name = "nvim_lsp";}
          {name = "luasnip";}
        ];
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end'';
        mapping = {
          "<Enter>" = ''function(fallback)
            if cmp.visible() and cmp.get_selected_entry() then
              cmp.confirm {
                select = true
              }
            else
              fallback()
            end
          end'';
          "<Tab>" = '' function(fallback)
            if cmp.visible() then
              cmp.select_next_item({behavior = cmp.SelectBehavior.Insert}) 
            else
              fallback()
            end
          end'';
          "<S-Tab>" = '' function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({behavior = cmp.SelectBehavior.Insert})
            else
              fallback()
            end
          end'';
        };
        experimental = {
          ghost_text = true;
        };
      };
    };
    cmp-nvim-lsp = {
      enable = true;
    };
    cmp-path = {
      enable = true;
    };
    cmp-tmux = {
      enable = true;
    };
    dap = {
      enable = true;
      configurations = {
      };
    };
    diffview = {
      enable = true;
    };
    direnv = {
      enable = true;
    };
    gitsigns = {
      enable = true;
    };
    indent-blankline = {
      enable = true;
    };
    lsp = {
      enable = true;
      servers = {
        clangd.enable = true;
        bashls.enable = true;
        cmake.enable = true;
        dockerls.enable = true;
        lua-ls.enable = true;
        rust-analyzer = {
          enable = true;
          installRustc = false;
          installCargo = false;
        };
        nil_ls.enable = true;
        marksman.enable = true;
        texlab.enable = true;
        pylsp.enable = true;
        tsserver.enable = true;
        cssls.enable = true;
      };
    };
    lualine = {
      enable = true;
    };
    luasnip = {
      enable = true;
    };
    neogit = {
      enable = true;
    };
    noice = {
      enable = true;
    };
    telescope = {
      enable = true;
      highlightTheme = "gruvbox-dark";
      extraOptions = {
        pickers = {
          find_files = {
            hidden = true;
          };
        };
      };
    };
    tmux-navigator = {
      enable = true;
    };
    treesitter = {
      enable = true;
    };
    treesitter-context = {
      enable = true;
    };
    which-key = {
      enable = true;
    };
  };
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = neoscroll-nvim;
      config = ''
        lua << EOF
          require("neoscroll").setup()
        EOF
      '';
    }
    {
      plugin = vim-sleuth;
    }
  ];
}
