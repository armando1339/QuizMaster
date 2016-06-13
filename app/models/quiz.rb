class Quiz < ActiveRecord::Base
	belongs_to	:user
	has_many 	:questions, dependent: :destroy
end
