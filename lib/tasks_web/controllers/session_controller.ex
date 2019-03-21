defmodule TasksWeb.SessionController do
  use TasksWeb, :controller
  # taken from Nat Tuck's users impl: https://khoury.neu.edu/~ntuck/courses/2019/01/cs4550/notes/11-add-users/notes.html
  def create(conn, %{"email" => email, "password" => password}) do
    user = Tasks.Users.get_user_by_email(email)
    with {:ok, user} <- Argon2.check_pass(user, password) do
      resp = %{
        data: %{
          token: Phoenix.Token.sign(TasksWeb.Endpoint, "user_id", user.id),
          user_id: user.id,
        }
      }
      conn
      |> put_resp_header("content-type", "application/json; charset=utf-8")
      |> send_resp(:created, Jason.encode!(resp))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
