module LoginUser
  def login_user role
    login_user = create(role, email: 'test@te.st', password: 'testing1')
    visit new_user_session_path
    fill_in 'Email', with: login_user.email
    fill_in 'Password', with: login_user.password
    within "form.new_user" do
      find('[name=commit]').click #click_button "Sign up"
    end

  end
end

World(LoginUser)
