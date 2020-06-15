Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :roles, except: :show
  resources :users, except: :show
  resources :permissions, only: %i[index create]
  resources :subjects, except: :show
  resources :students, except: :show
  resources :courses, except: :show
  resources :schedules, except: :show

  namespace :api do
    namespace :admin do
      resources :users
      resources :roles do
        collection do
          get :list_select
          get :get_list_all
        end
      end
      resources :permissions, only: %i[create] do
        collection do
          get :get_list
          post :remove
        end
      end
      resources :authorizations do
        collection do
          get :get_list
        end
      end
      resources :subjects do
        collection do
          get :get_list_department_option
          get :get_list_subject_type_option
          get :get_list_name_option
        end
      end
      resources :students do
        collection do
          get :get_list_program_option
          get :get_list_class_name_option
        end
      end
      resources :courses do
        collection do
          get :get_list_courses_status_option
        end
      end
    end
  end
end
