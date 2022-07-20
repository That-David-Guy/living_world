defmodule LivingWorldWeb.WorldLive.Index do
  use LivingWorldWeb, :live_view

  alias LivingWorld.Worlds
  alias LivingWorld.Worlds.World

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :worlds, list_worlds())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit World")
    |> assign(:world, Worlds.get_world!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New World")
    |> assign(:world, %World{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Worlds")
    |> assign(:world, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    world = Worlds.get_world!(id)
    {:ok, _} = Worlds.delete_world(world)

    {:noreply, assign(socket, :worlds, list_worlds())}
  end

  defp list_worlds do
    Worlds.list_worlds()
  end
end
