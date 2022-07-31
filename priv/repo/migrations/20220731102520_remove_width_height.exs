defmodule LivingWorld.Repo.Migrations.RemoveWidthHeight do
  use Ecto.Migration

  def change do
    alter table(:worlds) do
      remove :width
      remove :height
    end
  end
end
