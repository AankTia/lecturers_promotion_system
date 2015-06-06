Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :faculties
  resources :study_programs
  resources :percentage_assessments
  resources :rank_of_lecturers
  resources :lecturers do
    post :activate,   on: :member
    post :deactivate, on: :member
  end
  resources :assessment_ranges do
    post :activate,   on: :member
    post :deactivate, on: :member
  end
  resources :assessment_results do
    post :confirm,  on: :member
    post :revise,   on: :member
    post :cancel,   on: :member
    post :complete, on: :member
    post :create_list_of_ratings_execution_of_work, on: :member
  end
  resources :assessors do
    post :activate,   on: :member
    post :deactivate, on: :member
  end
  resources :list_of_ratings_execution_of_works do
    get :export_pdf, on: :member
    post :confirm,  on: :member
    post :revise,   on: :member
    post :cancel,   on: :member
    post :complete, on: :member
  end
  resources :preferments do
    post :confirm,  on: :member
    post :revise,   on: :member
    post :cancel,   on: :member
    post :complete, on: :member
  end
  resources :periodic_preferments do
    get :export_pdf, on: :member
    post :confirm,  on: :member
    post :revise,   on: :member
    post :cancel,   on: :member
    post :complete, on: :member
  end

end
