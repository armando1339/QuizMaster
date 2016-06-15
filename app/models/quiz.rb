class Quiz < ActiveRecord::Base
	belongs_to	:user
	has_many 	:questions, dependent: :destroy
	validates 	:name, :description, presence: true
end
