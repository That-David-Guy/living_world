defmodule LivingWorldWeb.WorldLive.ViewMapComponent do
  @moduledoc """
  Renders the map to view.

  This is my first attempt at a live_component, which is stateful.
  If I wanted a stateless component, I would want Phoenix.Component
  Ideally I think I want to use stateless as much as possible.any()

  """
  use LivingWorldWeb, :live_component

  alias LivingWorld.Landmass

  @impl true
  def handle_event("event_from_map_canvas", %{"name" => name, "origin_id" => origin_id, "payload" => payload}, socket) do
    if socket.assigns.world.id == origin_id do
      case name do
        "request_data" ->
            # If you do any database calls, move to preload method
            {:ok, landmass} = Landmass.generate(400, 400, payload["seed"])

            { :noreply,
            socket
            |> push_event(
              "event_for_map_canvas", %{name: "init_map_data",  origin_id: origin_id, payload: %{landmass: landmass.landmass}}
            )}
      end
    else
      {:noreply, socket}
    end
  end
end
