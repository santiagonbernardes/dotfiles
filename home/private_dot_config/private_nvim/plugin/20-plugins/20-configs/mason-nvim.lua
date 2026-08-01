require('mason').setup()

local packages = {
  'lua-language-server',
  'stylua',
  'pyright',
  'ruff',
  'shellcheck',
  'ansible-language-server',
  'ansible-lint',
  'rubocop',
}

require('mason-registry').refresh(function()
  local registry = require('mason-registry')
  local notify_helper = require('custom.helpers.notify')

  vim
    .iter(packages)
    :filter(function(pkg) return not registry.is_installed(pkg) end)
    :each(function(pkg_to_install)
      notify_helper.schedule_notify(
        ('Installing Mason Package: %s'):format(pkg_to_install)
      )

      local ok, pkg_or_err = pcall(registry.get_package, pkg_to_install)

      if not ok then
        notify_helper.schedule_notify(
          ('Package %s as not found in Mason Registry.\nCause: %s'):format(
            pkg_to_install,
            pkg_or_err
          ),
          vim.log.levels.ERROR
        )
        return
      end

      pkg_or_err:install(nil, function(success, receipt_or_err)
        if success then
          notify_helper.schedule_notify(
            ('Installed package %s successfully.'):format(pkg_to_install)
          )
          return
        end

        notify_helper.schedule_notify(
          ('Failed to install package %.\nCause: %s'):format(
            pkg_to_install,
            receipt_or_err
          ),
          vim.log.levels.ERROR
        )
      end)
    end)
end)
