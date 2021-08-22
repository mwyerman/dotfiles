local wk = require('which-key')

wk.register({
    p = {
        name = "packer",
        i = { ":PackerInstall<cr>", "install" },
        s = { ":PackerSync<cr>", "sync" },
        S = { ":PackerStatus<cr>", "status" },
        u = { ":PackerUpdate<cr>", "update" },
        c = { ":PackerClean<cr>", "clean" },
        C = { ":PackerCompile<cr>", "compile" },
    }
}, { prefix = "<leader>" })

wk.register({
    f = {
        name = "file",
        w = { ":w<cr>", "write" },
        W = { ":wq<cr>", "write & quit" },
        q = { ":q<cr>", "quit" },
        Q = { ":q!<cr>", "quit without saving" },
        S = { ":w !sudo tee %<cr>", "write with sudo" },
    }
}, { prefix = "<leader>" })