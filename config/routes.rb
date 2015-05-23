Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :faculties
  resources :study_programs
  resources :percentage_assessments
  resources :rank_of_lecturers
  resources :lecturers
  resources :assessment_results
  resources :assessors
  resources :list_of_ratings_execution_of_works do
    get :export_pdf, on: :member
  end
  resources :preferments
  resources :periodic_preferments do
    get :export_pdf, on: :member
  end

end
