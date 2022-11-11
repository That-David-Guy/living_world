defmodule LivingWorldWeb.MyWorldsLive.Index do
  use LivingWorldWeb, :live_view

  alias LivingWorld.UserFlows.MyWorlds
  # alias LivingWorld.Worlds.World

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :worlds, list_my_worlds(socket.assigns.current_user.id))}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    # {:noreply, apply_action(socket, socket.assigns.live_action, params)}
    {:noreply, socket}
  end

  defp list_my_worlds(user_id) do
    MyWorlds.list_my_worlds(user_id)
  end
end
