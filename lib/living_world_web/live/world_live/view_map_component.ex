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
  def handle_event("event_from_map_canvas", %{"name" => name, "payload" => _payload}, socket) do
    case name do
      "request_data" ->
          # TODO When using seed, this is where you would get the seed value
          # If you do any database calls, move to preload method
          {:ok, landmass} = Landmass.generate(400, 400)

          { :noreply,
          socket
          |> push_event(
            "event_for_map_canvas", %{name: "init_map_data", payload: %{landmass: landmass.landmass}}
          )}
    end
  end

  def handle_event("say_hello", _, socket) do
    # case name do
    #   "tiles_updated" -> {:noreply, assign(socket, :js_tiles, payload)}
    # end
    IO.inspect("!!! say_hello !!!")
    {:noreply, socket}
  end
end
