defmodule JogoMemoriaWeb.Router do
  use JogoMemoriaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {JogoMemoriaWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    # Habilita CORS para qualquer origem
    plug CORSPlug, origin: ["*"]
  end

  scope "/", JogoMemoriaWeb do
    pipe_through :browser

    get "/tela_inicial", PageController, :teste
    get "/game", PageController, :game

    # Obtenção de imagens
    get "/static/assets/images/unturned.png", PageController, :back
    get "/static/assets/images/pinklion.png", PageController, :get_img
    get "/static/assets/images/laelpfp.png", PageController, :get_img
    get "/static/assets/images/jv_pfp.png", PageController, :get_img

    get "/static/assets/images/clubsblock.png", PageController, :get_img
    get "/static/assets/images/clubsclover.png", PageController, :get_img

    get "/static/assets/images/diamondsblock.png", PageController, :get_img
    get "/static/assets/images/diamondsclover.png", PageController, :get_img

    get "/static/assets/images/heartsblock.png", PageController, :get_img
    get "/static/assets/images/heartsclover.png", PageController, :get_img

    get "/static/assets/images/spadesblock.png", PageController, :get_img
    get "/static/assets/images/spadesclover.png", PageController, :get_img

    # Obtenção de css e javascript
    get "/css/main.css", PageController, :get_css
    get "/javascript/js_page.js", PageController, :get_js
    get "/javascript/js_game.js", PageController, :get_js_game

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  scope "/api", JogoMemoriaWeb do
    pipe_through :api

    get "/playing", PageController, :playing
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:jogo_memoria, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: JogoMemoriaWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
