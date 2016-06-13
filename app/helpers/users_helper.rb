module UsersHelper
	def user_type_options
		@user_type_options = Array.new
		@types = User.subclasses
		@types.each do |t|
			@user_type_options << t.to_s
		end 
		@user_type_options
	end
end
