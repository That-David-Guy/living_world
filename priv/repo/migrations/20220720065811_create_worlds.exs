defmodule LivingWorld.Repo.Migrations.CreateWorlds do
  use Ecto.Migration

  def change do
    create table(:worlds) do
      add :seed, :integer, null: false
      add :width, :integer, null: false
      add :height, :integer, null: false

      timestamps()
    end
  end
end
