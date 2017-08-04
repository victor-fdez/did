defmodule Did.Router do
  use Did.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Did do
    pipe_through :api
    resources "/phone_ranges", PhoneRangeController, except: [:new, :edit]
  end
end
