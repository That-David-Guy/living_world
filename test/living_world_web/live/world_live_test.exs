defmodule LivingWorldWeb.WorldLiveTest do
  use LivingWorldWeb.ConnCase

  import Phoenix.LiveViewTest
  import LivingWorld.WorldsFixtures

  @create_attrs %{seed: 42}
  @update_attrs %{seed: 43}
  @invalid_attrs %{seed: nil}

  defp create_world(_) do
    world = world_fixture()
    %{world: world}
  end

  describe "Index" do
    setup [:create_world]

    test "lists all worlds", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.world_index_path(conn, :index))

      assert html =~ "Listing Worlds"
    end

    test "saves new world", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.world_index_path(conn, :index))

      assert index_live |> element("a", "New World") |> render_click() =~
               "New World"

      assert_patch(index_live, Routes.world_index_path(conn, :new))

      assert index_live
             |> form("#world-form", world: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#world-form", world: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.world_index_path(conn, :index))

      assert html =~ "World created successfully"
    end

    test "updates world in listing", %{conn: conn, world: world} do
      {:ok, index_live, _html} = live(conn, Routes.world_index_path(conn, :index))

      assert index_live |> element("#world-#{world.id} a", "Edit") |> render_click() =~
               "Edit World"

      assert_patch(index_live, Routes.world_index_path(conn, :edit, world))

      assert index_live
             |> form("#world-form", world: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#world-form", world: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.world_index_path(conn, :index))

      assert html =~ "World updated successfully"
    end

    test "deletes world in listing", %{conn: conn, world: world} do
      {:ok, index_live, _html} = live(conn, Routes.world_index_path(conn, :index))

      assert index_live |> element("#world-#{world.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#world-#{world.id}")
    end
  end

  describe "Show" do
    setup [:create_world]

    test "displays world", %{conn: conn, world: world} do
      {:ok, _show_live, html} = live(conn, Routes.world_show_path(conn, :show, world))

      assert html =~ "Show World"
    end

    test "updates world within modal", %{conn: conn, world: world} do
      {:ok, show_live, _html} = live(conn, Routes.world_show_path(conn, :show, world))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit World"

      assert_patch(show_live, Routes.world_show_path(conn, :edit, world))

      assert show_live
             |> form("#world-form", world: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#world-form", world: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.world_show_path(conn, :show, world))

      assert html =~ "World updated successfully"
    end
  end
end
