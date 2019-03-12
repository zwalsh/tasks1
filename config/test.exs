use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tasks2, TasksWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :tasks2, Tasks.Repo,
  username: "tasks2",
  password: "m1PN4Y33YG@r",
  database: "tasks2_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
