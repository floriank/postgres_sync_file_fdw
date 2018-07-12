defmodule PostgresSyncFileFdwWeb.Router do
  use PostgresSyncFileFdwWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PostgresSyncFileFdwWeb do
    pipe_through :api
  end
end
