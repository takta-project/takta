defmodule Auth.Repo.Migrations.CreateTokensTable do
  use Ecto.Migration

  def change do
    create table(:tokens, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :token, :string
      add :user_id, :uuid

      timestamps()
    end

    create index(:tokens, [:token])
    create index(:tokens, [:user_id])
  end
end
