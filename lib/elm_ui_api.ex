defmodule ElmUI.API do
  use Maru.Router
  use Application

  plug Corsica, origins: "*",
                allow_credentials: true,
                allow_headers: ["content-type"]

  mount ElmUI.Router.Videos
  mount ElmUI.Router.Folders

  rescue_from Ecto.InvalidChangesetError do
    status 400
    json conn, %{ error: "Bad request!" }
  end

  rescue_from Ecto.NoResultsError do
    status 404
    json conn, %{ error: "No result!" }
  end

  rescue_from Maru.Exceptions.InvalidFormatter do
    status 400
    json conn, %{ error: "Bad request!"}
  end

  rescue_from Maru.Exceptions.NotFound do
    status 404
    json conn, %{ error: "Not found!" }
  end

  # rescue_from :all do
  #   conn
  #   |> put_status(500)
  #   |> text("Server Error")
  # end

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(ElmUI.Repo, [])
    ]

    opts = [strategy: :one_for_one, name: ElmUI2.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
