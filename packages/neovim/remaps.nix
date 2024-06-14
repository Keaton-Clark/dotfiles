{
  plugins = {
    which-key = {
      enable = true;
      registrations = {
        "<leader>f" = "Find something with telescope or a picker";
        "<leader>g" = "Git tools";
        "<leader>l" = "Use the lsp";
        "<leader>h" = "Help!";
      };
      triggersNoWait = ["" "'" "g" "g'" "\"" "<c-r>" "z=" "<leader>"];
    };
  };
  keymaps = [
    {
      action = "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>";
      key = "<leader>ls";
      mode = ["n"];
      options = {
        silent = true;
        desc = "Symbols";
      };
    }
    {
      action = "<cmd>Telescope marks<cr>";
      key = "<leader>fm";
      mode = ["n"];
      options = {
        silent = true;
        desc = "Marks";
      };
    }
    {
      action = "<cmd>Telescope jumplist<cr>";
      key = "<leader>fj";
      mode = ["n"];
      options = {
        silent = true;
        desc = "Jumps";
      };
    }
    {
      action = "<cmd>Telescope lsp_definitions<cr>";
      key = "<leader>ld";
      mode = ["n"];
      options = {
        silent = true;
        desc = "Definitions/Declarations";
      };
    }
    {
      action = "<cmd>Telescope lsp_references<cr>";
      key = "<leader>lr";
      mode = ["n"];
      options = {
        silent = true;
        desc = "References";
      };
    }
    {
      action = "<cmd>ClangdSwitchSourceHeader<cr>";
      key = "<leader><Tab>";
      mode = ["n"];
      options = {
        silent = true;
        desc = "Source/Header";
      };
    }
    {
      action = "<cmd>Telescope man_pages<cr>";
      key = "<leader>hm";
      mode = ["n"];
      options = {
        silent = true;
        desc = "Man Pages";
      };
    }
    {
      action = "<cmd>Telescope keymaps<cr>";
      key = "<leader>hk";
      mode = ["n"];
      options = {
        silent = true;
        desc = "Keymaps";
      };
    }
    {
      action = "<cmd>bn<cr>";
      key = "<Tab>";
      mode = ["n"];
      options = {
        silent = true;
        desc = "Next Buffer";
      };
    }
    {
      action = "<cmd>bp<cr>";
      key = "<S-Tab>";
      mode = ["n"];
      options = {
        silent = true;
        desc = "Prev Buffer";
      };
    }
    {
      action = "<cmd>Telescope buffers<cr>";
      key = "<leader>fb";
      mode = ["n"];
      options = {
        silent = true;
        desc = "Find Buffer";
      };
    }
    {
      action = "<cmd>Telescope live_grep<cr>";
      key = "<leader>fs";
      mode = ["n"];
      options = {
        silent = true;
        desc = "Find String";
      };
    }
    {
      action = "<cmd>Telescope find_files<cr>";
      key = "<leader>ff";
      mode = ["n"];
      options = {
        silent = true;
        desc = "Find Files";
      };
    }
  ];
}
