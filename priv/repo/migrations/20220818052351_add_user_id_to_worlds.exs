defmodule LivingWorld.Repo.Migrations.AddUserIdToWorlds do
  use Ecto.Migration

  def change do
    alter table(:worlds) do
      add :user_id, references(:users)
    end

    create index(:worlds, [:user_id])
  end
end
