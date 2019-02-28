defmodule Tasks1Web.SessionController do
  use Tasks1Web, :controller
  # taken from Nat Tuck's users impl: https://khoury.neu.edu/~ntuck/courses/2019/01/cs4550/notes/11-add-users/notes.html
  def create(conn, %{"email" => email}) do
    user = Tasks1.Users.get_user_by_email(email)
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome back #{user.email}")
      |> redirect(to: Routes.page_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Login failed.")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
