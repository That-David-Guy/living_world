defmodule LivingWorld.Repo do
  use Ecto.Repo,
    otp_app: :living_world,
    adapter: Ecto.Adapters.Postgres
end
