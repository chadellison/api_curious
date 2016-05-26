Rails.application.routes.draw do
  root "welcome#index"

  get "/auth/github", as: :github_login
  get "/auth/github/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/dashboard", to: "users#show", as: :dashboard
  get "/users", to: "github_users#index"
  get "/users/:login", to: "github_users#show"
end
