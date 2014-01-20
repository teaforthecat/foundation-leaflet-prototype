account = Account.where(dcm_account_code: "ACME").first_or_create
user = User.where(email: "test@te.st").first_or_initialize
user.password = user.password_confirmation = "testing1"
user.account = account
user.save
