local inactive_pkgs_names = vim
  .iter(vim.pack.get())
  :filter(function(pkg) return not pkg.active end)
  :map(function(inactive_pkgs) return inactive_pkgs.spec.name end)
  :totable()

vim.pack.del(inactive_pkgs_names)
