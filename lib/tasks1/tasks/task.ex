defmodule Tasks1.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false
    field :desc, :string
    field :time_taken, :integer
    field :title, :string
    belongs_to :user_id, Tasks1.Users.User, foreign_key: :assignee_id, references: :id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :desc, :completed, :time_taken, :assignee_id])
    |> validate_required([:title, :desc, :completed, :time_taken])
  end
end
