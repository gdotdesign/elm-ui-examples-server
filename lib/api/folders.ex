defmodule ElmUI.Router.Folders do
  use Maru.Router

  import Ecto

  def breadcrumbs(folder, parents) do
    parent = ElmUI.Repo.get Folder, folder.folder_id
    if parent do
      parents ++ [parent] ++ breadcrumbs(parent, parents)
    else
      parents
    end
  end

  resource :folders do
    params do
      requires :folder_id, type: :integer
      requires :image, type: :string
      requires :name, type: :string
    end
    post do
      changeset = Folder.create(%Folder{}, params)
      folder = ElmUI.Repo.insert!(changeset)
      status 201
      json conn, folder
    end

    params do
      requires :id, type: :integer
    end
    route_param :id do
      params do
        optional :folder_id, type: :integer
        optional :image, type: :string
        optional :name, type: :string
      end
      patch do
        folder = ElmUI.Repo.get! Folder, params[:id]
        changeset = Folder.update folder, params
        folder = ElmUI.Repo.update! changeset
        json conn, folder
      end

      delete do
        ElmUI.Repo.delete! %Folder{id: params[:id]}
        json conn, %{ status: "ok" }
      end

      get do
        folder = ElmUI.Repo.get!(Folder, params[:id])
        json conn, folder
      end

      get :contents do
        folder = ElmUI.Repo.get! Folder, params[:id]
        folders = ElmUI.Repo.all assoc(folder, :folders)
        videos = ElmUI.Repo.all assoc(folder, :videos)
        json conn, %{ videos: videos,
                      folders: folders,
                      name: folder.name,
                      id: folder.id,
                      folder_id: folder.folder_id,
                      breadcrumbs: breadcrumbs(folder, []) }
      end
    end
  end
end
