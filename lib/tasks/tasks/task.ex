defmodule Tasks.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false
    field :desc, :string
    field :title, :string
    belongs_to :assignee, Tasks.Users.User, foreign_key: :assignee_id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :desc, :completed, :assignee_id])
    |> validate_required([:title, :desc, :completed])
  end
end
