defmodule JogoMemoriaWeb.PageController do
  use JogoMemoriaWeb, :controller
  alias JogosMemoria.Cards

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def teste(conn, _params) do
    conn
    |> put_resp_content_type("text/html")
    |> Plug.Conn.send_file(
      200,
      Path.join(:code.priv_dir(:jogo_memoria), "static/index.html")
    )
  end

  def game(conn, _params) do
    conn
    |> put_resp_content_type("text/html")
    |> Plug.Conn.send_file(200, Path.join(:code.priv_dir(:jogo_memoria), "static/game.html"))
  end

  # AREA DE IMAGENS, CSS E JAVASCRIPT
  def back(conn, _params) do
    conn
    |> put_resp_content_type("image/png")
    |> Plug.Conn.send_file(
      200,
      Path.join(:code.priv_dir(:jogo_memoria), "static/assets/images/unturned.png")
    )
  end

  def get_img(conn, _params) do
    caminho = conn.path_info
    img = List.last(caminho)

    conn
    |> put_resp_content_type("image/png")
    |> Plug.Conn.send_file(
      200,
      Path.join(:code.priv_dir(:jogo_memoria), "static/assets/images/#{img}")
    )
  end

  def get_css(_conn, _params), do: "priv/static/css/main.css"
  def get_js(_conn, _params), do: "priv/static/javascript/js_page.js"
  def get_js_game(_conn, _params), do: "priv/static/javascript/js_game.js"

  # AREA DE REQUISIÇÕES E RESPOSTAS
  def playing(conn, _params) do
    result = %{deck: Cards.embaralhar()}
    json(conn, result)
  end
end
