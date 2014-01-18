FactoryGirl.define do

  factory :dcm_account, class: DCM::Account do
    skip_create
  end

  factory :dcm_topic, class: DCM::Topic do
    skip_create
  end
end
