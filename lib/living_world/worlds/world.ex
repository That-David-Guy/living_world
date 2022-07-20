defmodule LivingWorld.Worlds.World do
  use Ecto.Schema
  import Ecto.Changeset

  schema "worlds" do
    field :height, :integer
    field :seed, :integer
    field :width, :integer

    timestamps()
  end

  @doc false
  def changeset(world, attrs) do
    world
    |> cast(attrs, [:seed, :width, :height])
    |> validate_required([:seed, :width, :height])
  end
end
