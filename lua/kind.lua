local execute = vim.api.nvim_command
local fn = vim.fn
local fmt = string.format

function clone_git_repository(user, repo)
  local path = fmt('~/.local/kind.nvim/%s', repo)

  print(path)

  if fn.empty(fn.glob(path)) > 0 then
    execute(fmt('!rm -rf %s', path))
    execute(fmt('!git clone git@github.com:%s/%s %s', user, repo, path))
  end
end

return {
  setup = function()
    clone_git_repository('HigherOrderCO', 'tree-sitter-kind')

    local parser_config = require("nvim-treesitter.parsers")
    if not parser_config then
      return
    end

    local parsers = parser_config.get_parser_configs()

    vim.cmd 'au BufRead,BufNewFile *.kind  set filetype=kind'
    vim.cmd 'au BufRead,BufNewFile *.kind2 set filetype=kind'

    parsers.kind = {
      install_info = {
        url = "~/.local/kind.nvim/tree-sitter-kind",
        files = {"src/parser.c"},
        -- optional entries:
        branch = "main",
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
      },
      filetype = "kind",
    }
  end
}
