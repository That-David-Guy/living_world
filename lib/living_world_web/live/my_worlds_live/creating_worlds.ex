defmodule LivingWorldWeb.MyWorldsLive.CreatingWorlds do
  use LivingWorldWeb, :live_view

  alias LivingWorld.UserFlows.MyWorlds
  # alias LivingWorld.Worlds.World

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :potential_worlds, list_randomised_worlds())}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    # {:noreply, apply_action(socket, socket.assigns.live_action, params)}
    {:noreply, socket}
  end

  @impl true
  def handle_event("pick_world", %{"seed" => seed}, socket) do
    case MyWorlds.pick_world(seed) do
      {:ok, _world} ->
        {:noreply,
         socket
         |> put_flash(:info, "World created")
         |> push_redirect(to: Routes.my_worlds_index_path(socket, :index)) # TODO find better way to do this
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp list_randomised_worlds do
    MyWorlds.list_randomised_worlds()
  end
end
