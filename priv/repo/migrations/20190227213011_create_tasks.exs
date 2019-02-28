defmodule Tasks1.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :desc, :string
      add :completed, :boolean, default: false, null: false
      add :time_taken, :integer
      add :assignee_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:assignee_id])
  end
end
