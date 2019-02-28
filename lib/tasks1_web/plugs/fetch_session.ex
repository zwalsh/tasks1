defmodule Tasks1Web.Plugs.FetchSession do
  import Plug.Conn
  # taken from Nat Tuck's users impl: https://khoury.neu.edu/~ntuck/courses/2019/01/cs4550/notes/11-add-users/notes.html
  def init(args), do: args

  def call(conn, _args) do
    user = Tasks1.Users.get_user(get_session(conn, :user_id) || -1)
    if user do
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end
end
