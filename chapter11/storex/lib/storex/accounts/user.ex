defmodule Storex.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Storex.Accounts.User

  schema "accounts_users" do
    field :email, :string
    field :full_name, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :full_name, :password])
    |> validate_required([:email, :full_name, :password])
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(changeset=%{valid?: true}) do
    password = get_change(changeset, :password)
    change(changeset, Comeonin.Bcrypt.add_hash(password))
  end
  defp put_password_hash(changeset) do
    changeset
  end

  def check_password(user, password) do
    Comeonin.Bcrypt.check_pass(user, password)
  end
end
