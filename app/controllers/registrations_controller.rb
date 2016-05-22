class THUPostRegistrationsController < Devise::RegistrationsController
  def new
    print("call new")
  end

  def create
    print("call create")
    super
  end
end
