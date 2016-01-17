defmodule ElmUI.Repo.Migrations.CreateFolders do
  use Ecto.Migration

  def change do
    create table(:folders) do
      add :folder_id, :integer
      add :image,     :string
      add :name,      :string

      timestamps
    end
  end
end
