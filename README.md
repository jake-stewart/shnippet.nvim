# shnippet
shit snippets

### example config
```lua
require("shnippet").setup({
    leader = "<c-f>",
    overrides = {},
    keys = {
        ["print"]    = "<c-j>",
        ["debug"]    = "<c-d>",
        ["error"]    = "<c-x>",
        ["while"]    = "<c-w>",
        ["for"]      = "<c-f>",
        ["if"]       = "<c-i>",
        ["elseif"]   = "<c-o>",
        ["else"]     = "<c-e>",
        ["switch"]   = "<c-s>",
        ["case"]     = "<c-v>",
        ["default"]  = "<c-b>",
        ["function"] = "<c-m>",
        ["lambda"]   = "<c-l>",
        ["class"]    = "<c-k>",
        ["struct"]   = "<c-h>",
        ["try"]      = "<c-t>",
        ["enum"]     = "<c-n>"
    }
})
require("shnippet").shnippet("<c-p>", "($0)")
```


### overrides
if you don't like a shnippet for a particular language, or wish to add your own, you can use the `overrides` option

```lua
require("shnippet").setup(
    overrides = {
        python = {  -- filetype
            extra = {
                ["<c-a>"] = "new shnippet"
            },
            print = false,  -- disable a shnippet
            class = "modified shnippet",
        },
    }
}
```

### adding your own languages

```lua
require("shnippet").addFtShnippets("holyc", {
    ["print"] = 'printf("$0\\n");',
    ["debug"] = "printf($0);",
    ["while"] = "while ($0) {\n}",
    ["for"] = "for ($0) {\n}",
    ["if"] = "if ($0) {\n}",
    ["elseif"] = "else if ($0) {\n}",
    ["else"] = "else {\n\t$0\n}",
    ["switch"] = "switch ($0) {\n}",
    ["case"] = 'case $0:\n\tbreak;',
    ["default"] = "default:\n\t$0\n\tbreak;",
    ["function"] = "$0 () {\n}",
    ["struct"] = "struct $0 {\n}",
})
```
