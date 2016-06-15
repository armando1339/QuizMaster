Rails.application.routes.draw do
  # play game
  resources :play_now, only: [:show] do
    get 'start_quiz',           on: :collection
    get 'answer_question',      on: :collection
    post 'evaluate_response',   on: :collection
    get 'result_of_quiz',      on: :collection
  end  
  # devise
  devise_scope :user do
    root 'users/sessions#new'
  end
  devise_for :users, controllers: {
    sessions:       'users/sessions',
    registrations:  'users/registrations'
  }
  # users
  namespace :users do
    resources :history_of_quizzes, only: [:index]
    resources :quizzes
    namespace :quizzes do 
      resources :questions
      namespace :questions do
        resources :answers
      end
    end
  end
  resources :users
  # quizwa
  resources :quizzes
  ###  end  ###

end
