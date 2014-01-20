account = Account.where(dcm_account_code: "ACME").first_or_create
user = User.where(email: "test@te.st").first_or_initialize do |user|
  user.password = user.password_confirmation = "testing1"
end

user.account = account
user.save
