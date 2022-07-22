defmodule LivingWorldWeb.PageController do
  #use Phoenix.LiveView
  use LivingWorldWeb, :controller

  def mount(_session, socket) do
    {:ok, socket}
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
