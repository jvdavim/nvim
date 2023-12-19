local util = require "formatter.util"

require("formatter").setup {
    filetype = {
        ocaml = {
            function()
                return {
                    exe = "dune",
                    args = {
                        "fmt"
                    }
                }
            end
        },
    }
}
