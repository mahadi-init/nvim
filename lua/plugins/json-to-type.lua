return {
  'Redoxahmii/json-to-types.nvim',
  build = 'sh install.sh npm', -- Replace `npm` with your preferred package manager (e.g., yarn, pnpm).
  ft = 'json',
  keys = {
    {
      '<leader>ts',
      '<CMD>ConvertJSONtoLang typescript<CR>',
      desc = 'Convert JSON to TS',
    },
    {
      '<leader>tb',
      '<CMD>ConvertJSONtoLang typescript-zod<CR>',
      desc = 'ConvertJSONtoLang typescript-zod',
    },
  },
}
