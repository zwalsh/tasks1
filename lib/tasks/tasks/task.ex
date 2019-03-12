defmodule Tasks.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false
    field :desc, :string
    field :time_taken, :integer
    field :title, :string
    belongs_to :assignee, Tasks.Users.User, foreign_key: :assignee_id

    timestamps()
  end

  def validate_minutes(changeset) do
    validate_change(changeset, :time_taken, fn :time_taken, t ->
      if !is_integer(t) do
        [time_taken: "must be an integer number of minutes"]
      else
        if t < 0 || rem(t, 15) != 0 do
          [time_taken: "must be a positive multiple of 15 minutes"]
        else
          []
        end
      end
    end)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :desc, :completed, :time_taken, :assignee_id])
    |> validate_required([:title, :desc, :completed, :time_taken])
    |> validate_minutes()
  end
end
