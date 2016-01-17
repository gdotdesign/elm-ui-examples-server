defmodule ElmUI.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :folder_id, :integer
      add :image,     :string
      add :name,      :string
      add :url,       :string

      timestamps
    end
  end
end
