return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  optional = true,
  keys = {
    {
      "<leader>fo",
      function()
        require("fzf-lua").projects()
      end,
      desc = "Projects",
    },
  },
  opts = {
    winopts = {
      border = false, -- Alternativa para quitar bordes
      fullscreen = false, -- Evita que ocupe toda la pantalla
      height = 0.9, -- Ajusta el tamaño de la ventana (0.9 = 90% de la pantalla)
      width = 0.8, -- Ajusta el ancho (0.8 = 80% de la pantalla)
      row = 0.5, -- Posición vertical (0.5 = centro)
      col = 0.5, -- Posición horizontal (0.5 = centro)
    },
  },
}
