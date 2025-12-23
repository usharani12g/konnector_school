Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check
  namespace :admin do
    resources :schools, except: [:show] do
      resources :school_admins, only: [:index, :new, :create, :destroy]
    end
  end


  namespace :school_admin do

    resource :school, only: [:edit, :update]

    resources :students, only: [:index, :new, :create]

    resources :courses, except: [:show] do
      resources :batches, except: [:show], shallow: true
    end

    get "batches", to: "batches#all_batches", as: :batches

    resources :batches, only: [:new, :create] do
      member do
        get  :students
        get  :assign_students
        post :save_students
      end
    end

    resources :enrollments, only: [:index] do
      member do
        patch :approve
        patch :reject
      end
    end
  end


  resources :enrollments, only: [:index, :create]

  resources :batches, only: [] do
    member do
      get :classmates
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :auth do
        post :login
      end

      namespace :school_admin do
        resources :courses, only: [:index, :create]
        resources :batches, only: [:index, :create] do
          member do
            post :assign_students
          end
        end
        resources :students, only: [:index, :create]
        resources :enrollments, only: [:index]
      end

      namespace :student do
        resources :batches, only: [:index]
        resources :enrollments, only: [:index, :create]
      end
    end
  end

end
