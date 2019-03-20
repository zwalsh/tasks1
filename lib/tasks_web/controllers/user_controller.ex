defmodule TasksWeb.UserController do
  use TasksWeb, :controller

  alias Tasks.Users
  alias Tasks.Users.User

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- Users.create_user(user_params) do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "User created successfully.")
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, user} <- Users.update_user(user, user_params) do
      conn
      |> put_flash(:info, "User updated successfully.")
      |> render("show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    with {:ok, _user} <- Users.delete_user(user) do
      conn
      |> put_flash(:info, "User deleted successfully.")
    end
  end
end
