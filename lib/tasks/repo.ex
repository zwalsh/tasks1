defmodule Tasks.Repo do
  use Ecto.Repo,
    otp_app: :tasks2,
    adapter: Ecto.Adapters.Postgres
end
