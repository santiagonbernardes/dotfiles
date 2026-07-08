return {
	"mfussenegger/nvim-jdtls",
	opts = function (_, opts)
    table.insert(opts.settings.java.configuration, {
      home = "/home/santi/.local/share/mise/installs/java/25.0.2",
      runtimes = {
        {
          name = "JavaSE-11",
          path = "/home/santi/.local/share/mise/installs/java/11.0.2",
        },
      },
    },
  )
  end,
}
