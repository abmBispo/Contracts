defmodule ContractsWeb.Router do
  use ContractsWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/api", ContractsWeb.Api do
    scope "/v1", V1 do
      pipe_through :api
      resources "/contracts", ContractController, except: [:new, :edit]
      resources "/parties", PartController, except: [:new, :edit]
    end
  end
end
