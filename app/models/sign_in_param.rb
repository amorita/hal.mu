class SignInParam
	include ActiveAttr::Model
 
  	attribute :email
	attribute :initial_access_token
	attribute :provider
end