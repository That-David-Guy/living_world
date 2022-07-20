defmodule LivingWorld.WorldsTest do
  use LivingWorld.DataCase

  alias LivingWorld.Worlds

  describe "worlds" do
    alias LivingWorld.Worlds.World

    import LivingWorld.WorldsFixtures

    @invalid_attrs %{height: nil, seed: nil, width: nil}

    test "list_worlds/0 returns all worlds" do
      world = world_fixture()
      assert Worlds.list_worlds() == [world]
    end

    test "get_world!/1 returns the world with given id" do
      world = world_fixture()
      assert Worlds.get_world!(world.id) == world
    end

    test "create_world/1 with valid data creates a world" do
      valid_attrs = %{height: 42, seed: 42, width: 42}

      assert {:ok, %World{} = world} = Worlds.create_world(valid_attrs)
      assert world.height == 42
      assert world.seed == 42
      assert world.width == 42
    end

    test "create_world/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Worlds.create_world(@invalid_attrs)
    end

    test "update_world/2 with valid data updates the world" do
      world = world_fixture()
      update_attrs = %{height: 43, seed: 43, width: 43}

      assert {:ok, %World{} = world} = Worlds.update_world(world, update_attrs)
      assert world.height == 43
      assert world.seed == 43
      assert world.width == 43
    end

    test "update_world/2 with invalid data returns error changeset" do
      world = world_fixture()
      assert {:error, %Ecto.Changeset{}} = Worlds.update_world(world, @invalid_attrs)
      assert world == Worlds.get_world!(world.id)
    end

    test "delete_world/1 deletes the world" do
      world = world_fixture()
      assert {:ok, %World{}} = Worlds.delete_world(world)
      assert_raise Ecto.NoResultsError, fn -> Worlds.get_world!(world.id) end
    end

    test "change_world/1 returns a world changeset" do
      world = world_fixture()
      assert %Ecto.Changeset{} = Worlds.change_world(world)
    end
  end
end
