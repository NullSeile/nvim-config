return {
    { -- Linting
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")

            lint.linters.c_trencada = {
                name = "c_trencada",
                cmd = "cç",
                args = {
                    "-check",
                },
                stdin = false,
                stream = "stderr",
                ignore_exitcode = true,

                parser = function(output, bufnr, linter_cwd)
                    local match = function(buffer_path, line)
                        local matches = { line:match([[^(%S+):(%d+).(%d+)-(%d+): (%S+): (.+)$]]) }
                        if not next(matches) then
                            return nil
                        end

                        local file = matches[1]

                        local path
                        if string.match(file, "^%w:") or vim.startswith(file, "/") then
                            path = file
                        else
                            path = vim.fn.simplify(linter_cwd .. "/" .. file)
                        end
                        if vim.fs.normalize(path) ~= vim.fs.normalize(buffer_path) then
                            return nil
                        end

                        local lnum = tonumber(matches[2]) - 1
                        local line_text = vim.api.nvim_buf_get_lines(bufnr or 0, lnum, lnum + 1, false)[1]
                        local col = vim.str_byteindex(line_text, "utf-16", tonumber(matches[3]) - 1, false)
                        local end_col = vim.str_byteindex(line_text, "utf-16", tonumber(matches[4]) - 1, false)
                        local severity = matches[5]
                        local message = matches[6]

                        local severity_map = {
                            ["Error"] = vim.lsp.protocol.DiagnosticSeverity.Error,
                            ["Avís"] = vim.lsp.protocol.DiagnosticSeverity.Warning,
                        }

                        return {
                            lnum = lnum,
                            end_lnum = lnum,
                            col = col,
                            end_col = end_col,
                            severity = severity_map[severity],
                            message = message,
                        }
                    end

                    local result = {}
                    local buffer_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p")
                    for line in vim.gsplit(output, "\n", true) do
                        local diagnostic = match(buffer_path, line, bufnr)
                        if diagnostic then
                            table.insert(result, diagnostic)
                        end
                    end
                    return result
                end,
                -- parser = function(output, bufnr, linter_cwd)
                --     if not vim.api.nvim_buf_is_valid(bufnr) then
                --         return {}
                --     end
                --     local result = {}
                --     local buffer_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p")
                --     --- bwc for 0.6 requires boolean arg instead of table
                --     ---@diagnostic disable-next-line: param-type-mismatch
                --     for line in vim.gsplit(output, "\n", true) do
                --         local diagnostic = match(linter_cwd, buffer_path, line, bufnr)
                --         if diagnostic then
                --             table.insert(result, diagnostic)
                --         end
                --     end
                --     return result
                -- end,

                -- parser = require("lint.parser").from_pattern(
                --     [[^(%S+):(%d+).(%d+)-(%d+): (%S+): (.+)$]],
                --     { "filename", "lnum", "col", "end_col", "severity", "message" },
                --     -- [[^(%S+):(%d+).(%d+): (%S+): (.+)$]],
                --     -- { "filename", "lnum", "col", "severity", "message" },
                --     {
                --         ["Error"] = vim.lsp.protocol.DiagnosticSeverity.Error,
                --         ["Avís"] = vim.lsp.protocol.DiagnosticSeverity.Warning,
                --     }
                -- ),
            }

            lint.linters_by_ft["c-trencada"] = { "c_trencada" }
            -- lint.linters_by_ft["typst"] = { "languagetool" }

            -- To allow other plugins to add linters to require('lint').linters_by_ft,
            -- instead set linters_by_ft like this:
            -- lint.linters_by_ft = lint.linters_by_ft or {}
            -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
            --
            -- However, note that this will enable a set of default linters,
            -- which will cause errors unless these tools are available:
            -- {
            --   clojure = { "clj-kondo" },
            --   dockerfile = { "hadolint" },
            --   inko = { "inko" },
            --   janet = { "janet" },
            --   json = { "jsonlint" },
            --   markdown = { "vale" },
            --   rst = { "vale" },
            --   ruby = { "ruby" },
            --   terraform = { "tflint" },
            --   text = { "vale" }
            -- }
            --
            -- You can disable the default linters by setting their filetypes to nil:
            -- lint.linters_by_ft['clojure'] = nil
            -- lint.linters_by_ft['dockerfile'] = nil
            -- lint.linters_by_ft['inko'] = nil
            -- lint.linters_by_ft['janet'] = nil
            -- lint.linters_by_ft['json'] = nil
            -- lint.linters_by_ft['markdown'] = nil
            -- lint.linters_by_ft['rst'] = nil
            -- lint.linters_by_ft['ruby'] = nil
            -- lint.linters_by_ft['terraform'] = nil
            -- lint.linters_by_ft['text'] = nil

            -- Create autocommand which carries out the actual linting
            -- on the specified events.
            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    -- Only run the linter in buffers that you can modify in order to
                    -- avoid superfluous noise, notably within the handy LSP pop-ups that
                    -- describe the hovered symbol using Markdown.
                    if vim.bo.modifiable then
                        lint.try_lint()
                    end
                end,
            })
        end,
    },
}
