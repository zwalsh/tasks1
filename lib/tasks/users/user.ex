defmodule Tasks.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :is_manager, :boolean
    has_many :tasks, Tasks.Tasks.Task, foreign_key: :assignee_id, on_delete: :nilify_all
    has_many :users, Tasks.Users.User, on_delete: :nilify_all
    belongs_to :manager, Tasks.Users.User, foreign_key: :manager_id


    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :manager_id])
    |> validate_required([:email])
  end
end
