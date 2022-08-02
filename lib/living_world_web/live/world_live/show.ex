defmodule LivingWorldWeb.WorldLive.Show do
  use LivingWorldWeb, :live_view

  alias LivingWorld.Worlds

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    world = Worlds.get_world!(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:world, world)
    }
  end

  defp page_title(:show), do: "Show World"
  defp page_title(:edit), do: "Edit World"
end
