defmodule JogoMemoria.Repo do
  use Ecto.Repo,
    otp_app: :jogo_memoria,
    adapter: Ecto.Adapters.Postgres
end
