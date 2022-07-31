defmodule LivingWorld.Worlds.World do
  use Ecto.Schema
  import Ecto.Changeset

  schema "worlds" do
    field :seed, :integer

    timestamps()
  end

  @doc false
  def changeset(world, attrs) do
    world
    |> cast(attrs, [:seed])
    |> validate_required([:seed])
  end
end
