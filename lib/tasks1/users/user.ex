defmodule Tasks1.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    has_many :tasks, Tasks1.Tasks.Task, foreign_key: :assignee_id, on_delete: :nilify_all

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_required([:email])
  end
end
