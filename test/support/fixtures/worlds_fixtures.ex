defmodule LivingWorld.WorldsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LivingWorld.Worlds` context.
  """

  @doc """
  Generate a world.
  """
  def world_fixture(attrs \\ %{}) do
    {:ok, world} =
      attrs
      |> Enum.into(%{
        height: 42,
        seed: 42,
        width: 42
      })
      |> LivingWorld.Worlds.create_world()

    world
  end
end
