return {
  settings = {
    pylsp = {
      plugins = {
        black = { enabled = true },
        isort = { enabled = true },
        flake8 = { enabled = false },
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
        mypy = { enabled = false },
        mccabe = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
      },
    }
  }
}
