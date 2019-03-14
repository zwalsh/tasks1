defmodule Tasks.Repo.Migrations.TasksRemoveTimeTaken do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      remove :time_taken
    end
  end
end
