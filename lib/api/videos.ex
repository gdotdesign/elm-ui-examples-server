defmodule ElmUI.Router.Videos do
  use Maru.Router

  resource :videos do
    params do
      requires :folder_id, type: :integer
      requires :image, type: :string
      requires :name, type: :string
      requires :url, type: :string
    end
    post do
      changeset = Video.create(%Video{}, params)
      video = ElmUI.Repo.insert!(changeset)
      status 201
      json conn, video
    end

    params do
      requires :id, type: :integer
    end
    route_param :id do
      params do
        optional :folder_id, type: :integer
        optional :image, type: :string
        optional :name, type: :string
        optional :url, type: :string
      end
      patch do
        video = ElmUI.Repo.get! Video, params[:id]
        changeset = Video.update video, params
        video = ElmUI.Repo.update! changeset
        json conn, video
      end

      delete do
        ElmUI.Repo.delete! %Video{id: params[:id]}
        json conn, %{ status: "ok" }
      end

      get do
        video = ElmUI.Repo.get!(Video, params[:id])
        json conn, video
      end
    end
  end
end
