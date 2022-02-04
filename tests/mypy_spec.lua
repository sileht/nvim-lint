describe(
  "linter.mypy",
  function()
    it(
      "parses output correctly",
      function()
        local parser = require("lint.linters.mypy").parser
        local bufnr = vim.uri_to_bufnr("file:///project/engine/worker.py")
        local result =
          parser(
          [[
engine/worker.py:105:30: error: Incompatible types in assignment (expression has type "str", variable has type "int")
    ]],
          bufnr,
          "/project"
        )
        assert.are.same(1, #result)

        local expected = {
          lnum = 104,
          end_lnum = 104,
          col = 29,
          end_col = 29,
          message = 'Incompatible types in assignment (expression has type "str", variable has type "int")',
          source = "mypy",
          severity = vim.diagnostic.severity.ERROR
        }
        assert.are.same(expected, result[1])
      end
    )
  end
)
