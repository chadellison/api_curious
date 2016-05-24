Rails.application.routes.draw do
  root "welcome#index"

  get "/auth/github", as: :github_login
  get "/auth/github/callback", to: "sessions#create"
  get "/dashboard_path", to: "dashboard#show"
end
