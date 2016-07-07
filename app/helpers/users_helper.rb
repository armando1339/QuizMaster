module UsersHelper
	def user_type_options
		@options = User.subclasses_array_options
	end
end
