FactoryGirl.define do
  factory :user do
    factory :account_admin do
      account
      roles ["account_admin"]
    end
  end

end
