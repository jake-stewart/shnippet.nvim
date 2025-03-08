local snippetLeader = "<c-f>"
local ftSnippets = {}
local ftSnippetOverrides = {}
local ftSnippetKeys = {}

--- @param lhs string
--- @param rhs string
--- @param opts vim.keymap.set.Opts
local function shnippet(lhs, rhs, opts)
    vim.keymap.set("i", snippetLeader .. lhs, function()
        vim.snippet.expand(rhs)
    end, opts)
end

local function setFiletypeShnippets()
    local snippets = ftSnippets[vim.o.ft]
    if not snippets then return end
    local overrides = ftSnippetOverrides[vim.o.ft] or {}
    for key, value in pairs(snippets) do
        if key == "extra" then
            for k, v in pairs(value) do
                if not overrides[k] then
                    shnippet(k, v, {buffer = true})
                end
            end
        elseif ftSnippetKeys[key] then
            if overrides[key] ~= nil then
                if overrides[key] then
                    shnippet(ftSnippetKeys[key],
                        overrides[key], {buffer = true})
                end
            else
                shnippet(ftSnippetKeys[key], value, {buffer = true})
            end
        end
    end
    if overrides.extra then
        for key, value in pairs(overrides.extra) do
            shnippet(key, value, {buffer = true})
        end
    end
end

local function addFtShnippets(ft, snippets)
    ftSnippets[ft] = snippets
    vim.api.nvim_create_autocmd("FileType", {
        pattern = ft,
        group = "FileTypeShnippets",
        callback = setFiletypeShnippets
    })
end

local function createFtSnippets()
    addFtShnippets("python", {
        extra = {
            ["-"] = "__$0__"
        },
        ["print"] = 'print("$0")',
        ["debug"] = "print($0)",
        ["error"] = "print($0)",
        ["while"] = "while $0:",
        ["for"] = "for $0:",
        ["if"] = "if $0:",
        ["elseif"] = "elif $0:",
        ["else"] = "else:\n\t$0",
        ["function"] = "def $0():",
        ["lambda"] = "lambda$0:",
        ["class"] = "class $0:",
        ["struct"] = "class $0:",
        ["try"] = "try:\n\t$0\nexcept Exception as e:\n\t...",
    })

    local shellSnippets = {
        ["print"] = 'echo "$0"',
        ["debug"] = "echo $0",
        ["error"] = "echo $0 >/dev/stderr",
        ["while"] = "while $0; do\ndone",
        ["for"] = "for $0; do\ndone",
        ["if"] = "if $0; then\nfi",
        ["elseif"] = "elif $0; then",
        ["else"] = "else\n\t$0",
        ["switch"] = "case $0 in\nesac",
        ["case"] = "$0)\n\t;;",
        ["default"] = "*)\n\t$0\n\t;;",
        ["function"] = "$0 () {\n}",
    }

    addFtShnippets("bash", shellSnippets)
    addFtShnippets("sh", shellSnippets)

    local jsSnippets = {
        ["print"] = 'console.log("$0");',
        ["debug"] = "console.log($0);",
        ["error"] = "console.error($0);",
        ["while"] = "while ($0) {\n}",
        ["for"] = "for ($0) {\n}",
        ["if"] = "if ($0) {\n}",
        ["elseif"] = "else if ($0) {\n}",
        ["else"] = "else {\n\t$0\n}",
        ["switch"] = "switch ($0) {\n}",
        ["case"] = 'case $0:\n\tbreak;',
        ["default"] = "default:\n\t$0\n\tbreak;",
        ["function"] = "function $0() {\n}",
        ["lambda"] = "($0) => {\n}",
        ["class"] = "class $0 {\n}",
        ["struct"] = "interface $0 {\n}",
        ["try"] = "try {\n\t$0\n}\ncatch (error) {\n}",
    }
    addFtShnippets("javascript", jsSnippets)
    addFtShnippets("typescript", jsSnippets)
    addFtShnippets("typescriptreact", jsSnippets)

    addFtShnippets("c", {
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

    addFtShnippets("cpp", {
        ["print"] = 'printf("$0\\n");',
        ["debug"] = "printf($0);",
        ["while"] = "while ($0) {\n}",
        ["for"] = "for ($0) {\n}",
        ["if"] = "if ($0) {\n}",
        ["elseif"] = "else if ($0) {\n}",
        ["else"] = "else {\n\t$0\n}",
        ["switch"] = "switch ($0) {\n}",
        ["case"] = "case $0:\n\tbreak;",
        ["default"] = "default:\n\t$0\n\tbreak;",
        ["function"] = "$0 () {\n}",
        ["lambda"] = "[]($0) {}",
        ["class"] = "class $0 {\n}",
        ["struct"] = "struct $0 {\n}",
        ["try"] = "try {\n\t$0\n}\ncatch {\n}",
    })

    addFtShnippets("java", {
        ["print"] = 'system.out.println("$0");',
        ["debug"] = "system.out.println($0);",
        ["while"] = "while ($0) {\n}",
        ["for"] = "for ($0) {\n}",
        ["if"] = "if ($0) {\n}",
        ["elseif"] = "else if ($0) {\n}",
        ["else"] = "else {\n\t$0\n}",
        ["switch"] = "switch ($0) {\n}",
        ["case"] = "case $0:\n\tbreak;",
        ["default"] = "default:\n\t$0\n\tbreak;",
        ["function"] = "$0 () {\n}",
        ["lambda"] = "($0) -> {}",
        ["class"] = "public class $0 {\n}",
        ["struct"] = "private class $0 {\n}",
        ["try"] = "try {\n\t$0\n}\ncatch {\n}",
    })

    addFtShnippets("cs", {
        ["print"] = 'Console.WriteLine("$0");',
        ["debug"] = "Console.WriteLine($0);",
        ["while"] = "while ($0) {\n}",
        ["for"] = "for ($0) {\n}",
        ["if"] = "if ($0) {\n}",
        ["elseif"] = "else if ($0) {\n}",
        ["else"] = "else {\n\t$0\n}",
        ["switch"] = "switch ($0) {\n}",
        ["case"] = "case $0:\n\tbreak;",
        ["default"] = "default:\n\t$0\n\tbreak;",
        ["function"] = "$0 () {\n}",
        ["lambda"] = "($0) => {}",
        ["class"] = "class $0 {\n}",
        ["struct"] = "struct $0 {\n}",
        ["try"] = "try {\n\t$0\n}\ncatch {\n}",
    })

    addFtShnippets("lua", {
        ["print"] = 'vim.print("$0")',
        ["debug"] = "vim.print($0)",
        ["while"] = "while $0 do\nend",
        ["for"] = "for $0 do\nend",
        ["if"] = "if $0 then\nend",
        ["elseif"] = "elseif $0 then",
        ["else"] = "else\n\t$0",
        ["function"] = "local function $0()\nend",
        ["lambda"] = "function($0)\nend",
        ["try"] = "pcall(function($0)\nend)",
    })

    addFtShnippets("rust", {
        ["print"] = 'println!("$0");',
        ["debug"] = "dbg!(&$0);",
        ["while"] = "while $0 {\n}",
        ["for"] = "for $0 {\n}",
        ["if"] = "if $0 {\n}",
        ["elseif"] = "else if $0 {\n}",
        ["else"] = "else {\n\t$0\n}",
        ["switch"] = "match $0 {\n}",
        ["enum"] = "enum $0 {\n}",
        ["struct"] = "struct $0 {\n}",
        ["function"] = "fn $0() {\n}",
    })

    addFtShnippets("go", {
        ["print"] = 'fmt.Println("$0")',
        ["debug"] = "fmt.Println($0)",
        ["while"] = "for $0 {\n}",
        ["for"] = "for $0 {\n}",
        ["if"] = "if $0 {\n}",
        ["elseif"] = "else if $0 {\n}",
        ["else"] = "else {\n\t$0\n}",
        ["switch"] = "switch $0 {\n}",
        ["case"] = "case $0:\n\tfallthrough",
        ["default"] = "default:\n\t",
        ["function"] = "func $0() {\n}",
        ["struct"] = "type $0 struct {\n}",
    })
end

local function setup(opts)
    opts = opts or {}
    ftSnippetOverrides = opts.overrides or {}
    snippetLeader = opts.leader or snippetLeader
    ftSnippetKeys = opts.keys or {}
    vim.api.nvim_create_augroup("FileTypeShnippets", { clear = true })
    createFtSnippets()
    if vim.o.ft then
        setFiletypeShnippets()
    end
end

return {
    setup = setup,
    addFtShnippets = addFtShnippets,
    snippet = shnippet,
}
