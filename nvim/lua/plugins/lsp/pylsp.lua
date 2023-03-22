return {
  settings = {
    pylsp = {
      plugins = {
        black = { enabled = false },
        isort = { enabled = false },
        flake8 = { enabled = false },
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
        mypy = { enabled = true },
        mccabe = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        jedi_completion = { enabled = true },
      },
    }
  }
}
