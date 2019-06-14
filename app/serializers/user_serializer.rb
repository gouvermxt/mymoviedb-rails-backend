# Serializes an User instance
class UserSerializer < Blueprinter::Base
  identifier :id

  fields(:name, :email)
end
