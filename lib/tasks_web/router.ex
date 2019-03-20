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
  end

  scope "/api", TasksWeb do
     pipe_through :api

     resources "/users", UserController, except: [:new, :edit]
     resources "/tasks", TaskController, except: [:new, :edit]
     post "/auth", AuthController, :authenticate
   end
end
