{
  keymaps = [
    {
      action = "<cmd>Telescope keymaps<cr>";
      key = "<leader>hk";
      mode = ["n"];
      options = {
        silent = true;
        desc = "Help Keymaps";
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
