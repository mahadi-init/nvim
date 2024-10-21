return {
  'L3MON4D3/LuaSnip',
  -- follow latest release.
  version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = 'make install_jsregexp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    local ls = require 'luasnip'
    local s = ls.snippet
    local i = ls.insert_node
    local t = ls.text_node

    -- React functional component snippet
    ls.add_snippets('typescript', {
      s('rfc', {
        t { "import React from 'react';", '', 'export default function ' },
        i(1, 'ComponentName'),
        t { '() {', '\treturn (' },
        t { '', '\t\t<div>' },
        i(2, 'content'),
        t { '</div>', '\t);', '};' },
      }),
    })

    -- Function declaration snippet
    ls.add_snippets('typescript', {
      s('fn', {
        t 'function ',
        i(1, 'name'),
        t '(',
        i(2, 'params'),
        t { ') {', '\t' },
        i(3, 'body'),
        t { '', '}' },
      }),
    })

    -- Function declaration snippet
    ls.add_snippets('typescript', {
      s('afn', {
        t 'export async function ',
        i(1, 'name'),
        t '(',
        i(2, 'params'),
        t { ') {', '\t' },
        i(3, 'body'),
        t { '', '}' },
      }),
    })

    -- Exported function snippet
    ls.add_snippets('typescript', {
      s('efn', {
        t 'export function ',
        i(1, 'functionName'),
        t { '() {', '\t' },
        i(2, '// your code here'),
        t { '', '}' },
      }),
    })

    -- Arrow function snippet
    ls.add_snippets('typescript', {
      s('af', {
        t 'const ',
        i(1, 'name'),
        t ' = (',
        i(2, 'params'),
        t { ') => {', '\t' },
        i(3, 'body'),
        t { '', '};' },
      }),
    })
  end,
}
