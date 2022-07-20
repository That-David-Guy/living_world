defmodule LivingWorldWeb.PageController do
  #use Phoenix.LiveView
  use LivingWorldWeb, :controller
  alias LivingWorld.Landmass



  def mount(_session, socket) do
    #changeset = Accounts.change_client(%Client{})
    IO.inspect("MOUNT")
    {:ok, socket}
  end

  def index(conn, _params) do
    render(conn, "index.html", deploy_step: "3")
  end

  def handle_event("change_value", _value, socket) do
    IO.inspect("CHANGING VALUE")
    {:noreply, assign(socket, :deploy_step, "!!!CHANGED!!!")}
  end



  # def handle_event("generate_landmass", _values, socket) do
  #   {:ok, landmass} = Landmass.generate(400, 400) |> IO.inspect
  #   {:noreply, assign(socket, :deploy_step, "1")}
  # end

  # def handle_event("inc_temperature", _value, socket) do
  #   {:ok, new_temp} = {:ok, 5} |> IO.inspect #Thermostat.inc_temperature(socket.assigns.id)
  #   {:noreply, assign(socket, :deploy_step, "2")}
  # end

  # def handle_event("clear", _params, socket) do
  #   IO.inspect("clicked clear")
  #   {:noreply, assign(socket, :deploy_step, "3")}
  # end
end
