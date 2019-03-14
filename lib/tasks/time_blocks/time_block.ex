defmodule Tasks.TimeBlocks.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset


  schema "time_blocks" do
    field :end, :utc_datetime
    field :start, :utc_datetime
    belongs_to :task, Tasks.Tasks.Task, foreign_key: :task_id

    timestamps()
  end

  @doc false
  def changeset(time_block, attrs) do
    time_block
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
  end
end
