defmodule LivingWorldWeb.WorldLive.FormComponent do
  use LivingWorldWeb, :live_component

  alias LivingWorld.Worlds

  @impl true
  def update(%{world: world} = assigns, socket) do
    changeset = Worlds.change_world(world)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"world" => world_params}, socket) do
    changeset =
      socket.assigns.world
      |> Worlds.change_world(world_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"world" => world_params}, socket) do
    save_world(socket, socket.assigns.action, world_params)
  end

  defp save_world(socket, :edit, world_params) do
    case Worlds.update_world(socket.assigns.world, world_params) do
      {:ok, _world} ->
        {:noreply,
         socket
         |> put_flash(:info, "World updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_world(socket, :new, world_params) do
    case Worlds.create_world(world_params) do
      {:ok, _world} ->
        {:noreply,
         socket
         |> put_flash(:info, "World created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
