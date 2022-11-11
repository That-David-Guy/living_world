defmodule LivingWorld.UserFlows.MyWorlds do
  @moduledoc """
    Funcations for handling the My Worlds user flows

    My Worlds user flow is when the user create and saves worlds for themselves
  """
  alias LivingWorld.Worlds

  def list_my_worlds(user_id) do
    Worlds.list_worlds(user_id)
  end

  def list_randomised_worlds do
    initial_seed = Enum.random(1..9_999)

    initial_seed..initial_seed+8
    |> Enum.map(& %{seed: trunc(&1*5), id: 9999+&1})
    |> IO.inspect
  end

  def pick_world(seed, user_id) do
    attrs = %{seed: seed, user_id: user_id}
    Worlds.create_world(attrs)
  end
end
