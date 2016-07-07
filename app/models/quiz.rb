class Quiz < ActiveRecord::Base
	belongs_to	:user
	has_many 	:questions, dependent: :destroy
	validates 	:name, :description, :user_id, presence: true

	filterrific(
	  default_filter_params: { sorted_by: 'created_at' },
	  available_filters: [
	    :sorted_by,
	    :search_query
	  ]
	)

	scope :search_query, lambda { |query|
	  return nil  if query.blank?
	  terms = query.downcase.split(/\s+/)
	  terms = terms.map { |e|
	    (e.gsub('*', '%') + '%').gsub(/%+/, '%')
	  }
	  num_or_conds = 1
	  where(
	    terms.map { |term|
	      "(LOWER(quizzes.name) LIKE ?)"
	    }.join(' AND '),
	    *terms.map { |e| [e] * num_or_conds }.flatten
	  )
	}

	scope :sorted_by, lambda { |sort_option|
		order(sort_option)
	}
end
