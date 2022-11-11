defmodule LivingWorld.Worlds.World do
  use Ecto.Schema
  import Ecto.Changeset

  schema "worlds" do
    field :seed, :integer
    belongs_to :user, LivingWorld.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(world, attrs) do
    world
    |> cast(attrs, [:seed, :user_id])
    |> validate_required([:seed, :user_id])
  end
end
