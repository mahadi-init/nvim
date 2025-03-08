return {
  'Redoxahmii/json-to-types.nvim',
  build = 'sh install.sh npm',
  event = 'VeryLazy',
  ft = 'json',
  keys = {
    {
      '<leader>ts',
      '<CMD>ConvertJSONtoLang typescript<CR>',
      desc = 'Convert JSON to TS',
    },
    {
      '<leader>tz',
      '<CMD>ConvertJSONtoLang typescript-zod<CR>',
      desc = 'Convert JSON to TS zod',
    },
  },
}
