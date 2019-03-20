defmodule TasksWeb.UserView do
  use TasksWeb, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, TasksWeb.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, TasksWeb.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email}
  end
end
