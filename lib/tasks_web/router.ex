defmodule TasksWeb.Router do
  use TasksWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug TasksWeb.Plugs.FetchSession
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TasksWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/users", UserController
    get "/tasks/personal", TaskController, :personal_tasks
    resources "/tasks", TaskController

    # taken from Nat Tuck's users impl: https://khoury.neu.edu/~ntuck/courses/2019/01/cs4550/notes/11-add-users/notes.html
    resources "/sessions", SessionController, only: [:create, :delete], singleton: true

    resources "/time_blocks", TimeBlockController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TasksWeb do
  #   pipe_through :api
  # end
end
