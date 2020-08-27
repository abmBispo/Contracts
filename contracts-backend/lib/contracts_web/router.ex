defmodule ContractsWeb.Router do
  use ContractsWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/api", ContractsWeb.Api do
    scope "/v1", V1 do
      pipe_through :api
      resources "/contracts", ContractController, except: [:new, :edit] do
        get "/parties", RelationController, :contract_parts
      end

      resources "/parties", PartController, except: [:new, :edit] do
        get "/contracts", RelationController, :part_contracts
      end

      post "/agreement/relation", RelationController, :create, as: :create_agreement_relation
      delete "/agreement/relation", RelationController, :delete, as: :delete_agreement_relation
    end
  end
end
