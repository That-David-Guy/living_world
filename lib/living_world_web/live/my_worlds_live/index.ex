defmodule LivingWorldWeb.MyWorldsLive.Index do
  use LivingWorldWeb, :live_view

  # alias LivingWorld.Worlds
  # alias LivingWorld.Worlds.World

  @impl true
  def mount(_params, _session, socket) do
    # {:ok, assign(socket, :worlds, list_worlds())}
    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    # {:noreply, apply_action(socket, socket.assigns.live_action, params)}
    {:noreply, socket}
  end
end
