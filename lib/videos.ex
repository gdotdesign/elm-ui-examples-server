defmodule Video do
  use Ecto.Schema

  import Ecto.Changeset

  @fields [:folder_id, :image, :name, :url]
  @derive {Poison.Encoder, only: @fields ++ [:id]}

  def create(video, params \\ :empty) do
    cast(video, params, @fields, [])
  end

  def update(video, params \\ :empty) do
  	cast(video, params, [], @fields)
  end

  schema "videos" do
    belongs_to :folder, Folder

    field :image,     :string
    field :name,      :string
    field :url,       :string

    timestamps
  end
end

defmodule Folder do
  use Ecto.Schema

  import Ecto.Changeset

  @fields [:folder_id, :image, :name]
  @derive {Poison.Encoder, only: @fields ++ [:id]}

  def create(video, params \\ :empty) do
    cast(video, params, @fields, [])
  end

  def update(video, params \\ :empty) do
    cast(video, params, [], @fields)
  end

  schema "folders" do
    has_many :folders, Folder, on_delete: :delete_all
    has_many :videos, Video, on_delete: :delete_all

    belongs_to :folder, Folder

    field :image,     :string
    field :name,      :string

    timestamps
  end
end
