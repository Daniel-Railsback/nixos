
{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dan";
  home.homeDirectory = "/home/dan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  #Allow home-manager to mess with bash alias
  home.file.".bashrc".force = true;
  #home-manager.backupFileExtension = "hm-backup";

  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  programs.neovim = {
    enable       = true;
    viAlias      = true;
    vimAlias     = true;
    withPython3  = true;
    plugins = with pkgs.vimPlugins; [
      dracula-nvim
      nvim-lspconfig
      nvim-tree-lua
      nvim-cmp
      telescope-nvim
      cmp-nvim-lsp
    ];


    extraPackages = with pkgs.vimPlugins; [
      nvim-web-devicons   # icons for the tree
      cmp-buffer          # buffer source for cmp
      cmp-path            # path source for cmp
    ];



    extraLuaConfig = ''
      -- set leader to Space
      vim.g.mapleader = ' '

      -- UI tweaks
      vim.o.number = true
      vim.o.relativenumber = true
      vim.cmd('colorscheme dracula')

      -- Telescope fuzzy finder mappings
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', function() builtin.find_files() end, { desc = 'Telescope Find' })

      -- Nvim-Tree file explorer
      require('nvim-tree').setup {
        view = { side = 'left', width = 30 },
        git = { enable = true },
        renderer = { icons = { show = { git = true, folder = true, file = true } } },
      }
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle File Explorer' })

      -- LSP & completion boilerplate
      local lspconfig = require('lspconfig')
      local cmp       = require('cmp')
      local caps      = require('cmp_nvim_lsp').default_capabilities()

      for _, srv in ipairs({ 'nil_ls', 'pylsp', 'bashls' }) do
        lspconfig[srv].setup { capabilities = caps }
      end

      cmp.setup {
        mapping = cmp.mapping.preset.insert {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>']      = cmp.mapping.confirm { select = true },
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer'   },
          { name = 'path'     },
        },
      }
    '';
  };
  


  programs.bash = {
   enable = true;
   shellAliases = {
    gs = "git status";
    nrebuild = "sudo nixos-rebuild switch --flake /etc/nixos\#TheoNixos";
   };
  }; 
}
