# == Route Map
#
#                         Prefix Verb       URI Pattern                                Controller#Action
#            pages_privacypolicy GET        /pages/privacypolicy(.:format)             pages#privacypolicy
#         new_admin_user_session GET        /admin/login(.:format)                     active_admin/devise/sessions#new
#             admin_user_session POST       /admin/login(.:format)                     active_admin/devise/sessions#create
#     destroy_admin_user_session DELETE|GET /admin/logout(.:format)                    active_admin/devise/sessions#destroy
#            admin_user_password POST       /admin/password(.:format)                  active_admin/devise/passwords#create
#        new_admin_user_password GET        /admin/password/new(.:format)              active_admin/devise/passwords#new
#       edit_admin_user_password GET        /admin/password/edit(.:format)             active_admin/devise/passwords#edit
#                                PATCH      /admin/password(.:format)                  active_admin/devise/passwords#update
#                                PUT        /admin/password(.:format)                  active_admin/devise/passwords#update
#                     admin_root GET        /admin(.:format)                           admin/dashboard#index
#    batch_action_admin_projects POST       /admin/projects/batch_action(.:format)     admin/projects#batch_action
#                 admin_projects GET        /admin/projects(.:format)                  admin/projects#index
#                                POST       /admin/projects(.:format)                  admin/projects#create
#              new_admin_project GET        /admin/projects/new(.:format)              admin/projects#new
#             edit_admin_project GET        /admin/projects/:id/edit(.:format)         admin/projects#edit
#                  admin_project GET        /admin/projects/:id(.:format)              admin/projects#show
#                                PATCH      /admin/projects/:id(.:format)              admin/projects#update
#                                PUT        /admin/projects/:id(.:format)              admin/projects#update
#                                DELETE     /admin/projects/:id(.:format)              admin/projects#destroy
#               sort_admin_tasks POST       /admin/tasks/sort(.:format)                admin/tasks#sort
#       batch_action_admin_tasks POST       /admin/tasks/batch_action(.:format)        admin/tasks#batch_action
#                    admin_tasks GET        /admin/tasks(.:format)                     admin/tasks#index
#                                POST       /admin/tasks(.:format)                     admin/tasks#create
#                 new_admin_task GET        /admin/tasks/new(.:format)                 admin/tasks#new
#                edit_admin_task GET        /admin/tasks/:id/edit(.:format)            admin/tasks#edit
#                     admin_task GET        /admin/tasks/:id(.:format)                 admin/tasks#show
#                                PATCH      /admin/tasks/:id(.:format)                 admin/tasks#update
#                                PUT        /admin/tasks/:id(.:format)                 admin/tasks#update
#                                DELETE     /admin/tasks/:id(.:format)                 admin/tasks#destroy
# batch_action_admin_admin_users POST       /admin/admin_users/batch_action(.:format)  admin/admin_users#batch_action
#              admin_admin_users GET        /admin/admin_users(.:format)               admin/admin_users#index
#                                POST       /admin/admin_users(.:format)               admin/admin_users#create
#           new_admin_admin_user GET        /admin/admin_users/new(.:format)           admin/admin_users#new
#          edit_admin_admin_user GET        /admin/admin_users/:id/edit(.:format)      admin/admin_users#edit
#               admin_admin_user GET        /admin/admin_users/:id(.:format)           admin/admin_users#show
#                                PATCH      /admin/admin_users/:id(.:format)           admin/admin_users#update
#                                PUT        /admin/admin_users/:id(.:format)           admin/admin_users#update
#                                DELETE     /admin/admin_users/:id(.:format)           admin/admin_users#destroy
#                admin_dashboard GET        /admin/dashboard(.:format)                 admin/dashboard#index
#       batch_action_admin_users POST       /admin/users/batch_action(.:format)        admin/users#batch_action
#                    admin_users GET        /admin/users(.:format)                     admin/users#index
#                                POST       /admin/users(.:format)                     admin/users#create
#                 new_admin_user GET        /admin/users/new(.:format)                 admin/users#new
#                edit_admin_user GET        /admin/users/:id/edit(.:format)            admin/users#edit
#                     admin_user GET        /admin/users/:id(.:format)                 admin/users#show
#                                PATCH      /admin/users/:id(.:format)                 admin/users#update
#                                PUT        /admin/users/:id(.:format)                 admin/users#update
#                                DELETE     /admin/users/:id(.:format)                 admin/users#destroy
#                 admin_comments GET        /admin/comments(.:format)                  admin/comments#index
#                                POST       /admin/comments(.:format)                  admin/comments#create
#                  admin_comment GET        /admin/comments/:id(.:format)              admin/comments#show
#                                DELETE     /admin/comments/:id(.:format)              admin/comments#destroy
#               new_user_session GET        /login(.:format)                           devise/sessions#new
#                   user_session POST       /login(.:format)                           devise/sessions#create
#           destroy_user_session DELETE     /logout(.:format)                          devise/sessions#destroy
#        user_omniauth_authorize GET|POST   /auth/:provider(.:format)                  omniauth_callbacks#passthru {:provider=>/google_oauth2|facebook|github/}
#         user_omniauth_callback GET|POST   /auth/:action/callback(.:format)           omniauth_callbacks#:action
#                  user_password POST       /password(.:format)                        devise/passwords#create
#              new_user_password GET        /password/new(.:format)                    devise/passwords#new
#             edit_user_password GET        /password/edit(.:format)                   devise/passwords#edit
#                                PATCH      /password(.:format)                        devise/passwords#update
#                                PUT        /password(.:format)                        devise/passwords#update
#       cancel_user_registration GET        /cancel(.:format)                          users/registrations#cancel
#              user_registration POST       /                                          users/registrations#create
#          new_user_registration GET        /sign_up(.:format)                         users/registrations#new
#         edit_user_registration GET        /profile(.:format)                         users/registrations#edit
#                                PATCH      /                                          users/registrations#update
#                                PUT        /                                          users/registrations#update
#                                DELETE     /                                          users/registrations#destroy
#                    pages_about GET        /pages/about(.:format)                     pages#about
#                     myprojects GET        /myprojects(.:format)                      project#list
#                           free POST       /free(.:format)                            charge#free
#                           root GET        /                                          project#index
#                   project_task GET        /project/:project_id/task/:id(.:format)    task#show
#                  project_index GET        /project(.:format)                         project#index
#                                POST       /project(.:format)                         project#create
#                    new_project GET        /project/new(.:format)                     project#new
#                   edit_project GET        /project/:id/edit(.:format)                project#edit
#                        project GET        /project/:id(.:format)                     project#show
#                                PATCH      /project/:id(.:format)                     project#update
#                                PUT        /project/:id(.:format)                     project#update
#                                DELETE     /project/:id(.:format)                     project#destroy
#                project_reviews POST       /project/:project_id/reviews(.:format)     reviews#create
#                 project_review DELETE     /project/:project_id/reviews/:id(.:format) reviews#destroy
#                                GET        /project(.:format)                         project#index
#                                POST       /project(.:format)                         project#create
#                                GET        /project/new(.:format)                     project#new
#                                GET        /project/:id/edit(.:format)                project#edit
#                                GET        /project/:id(.:format)                     project#show
#                                PATCH      /project/:id(.:format)                     project#update
#                                PUT        /project/:id(.:format)                     project#update
#                                DELETE     /project/:id(.:format)                     project#destroy
#                          blogs GET        /blogs(.:format)                           blogs#index
#                                POST       /blogs(.:format)                           blogs#create
#                       new_blog GET        /blogs/new(.:format)                       blogs#new
#                      edit_blog GET        /blogs/:id/edit(.:format)                  blogs#edit
#                           blog GET        /blogs/:id(.:format)                       blogs#show
#                                PATCH      /blogs/:id(.:format)                       blogs#update
#                                PUT        /blogs/:id(.:format)                       blogs#update
#                                DELETE     /blogs/:id(.:format)                       blogs#destroy
#

Rails.application.routes.draw do

resources :plans, only: [:new, :create, :index]

  get 'pages/privacypolicy'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile' },
              controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'users/registrations' }

  get 'pages/about'
  get '/myprojects' => 'project#list'
  post '/free' => 'charge#free'

  root 'project#index'

  resources :project do
  resources :task, only: [:show]
  end

  resources :project do
    resources :reviews, only: [:create, :destroy]
  end
  resources :credit_cards, only: [:new, :destroy]
  post 'credit_cards/:plan_id', to: 'credit_cards#new'
  resources :blogs
  post '/webhook', to: 'credit_cards#create'
  resource :subscriptions, only: [:create]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
