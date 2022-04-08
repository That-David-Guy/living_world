defmodule LivingWorldWeb.PageController do
  use LivingWorldWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
