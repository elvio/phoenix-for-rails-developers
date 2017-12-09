defmodule Storex.Accounts do
  import Ecto.Query, warn: false
  alias Storex.Repo
  alias Storex.Accounts.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def new_user() do
    User.changeset(%User{}, %{})
  end

  def authenticate_user(email, password) do
    Repo.get_by(User, email: email)
    |> User.check_password(password)
  end
end
