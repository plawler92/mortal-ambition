defmodule MortalAmbition.Repo do
  use Ecto.Repo,
    otp_app: :mortal_ambition,
    adapter: Ecto.Adapters.Postgres
end
