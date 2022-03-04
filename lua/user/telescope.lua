require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      '.angular/*',
      '.angular/**',
      '.angular',
      '.git',
      'node_modules',
      'dist'
    }
  }
})
