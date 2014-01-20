FactoryGirl.define do
  factory :e911 do
    subscriber_list { open('tmp/chicago.csv') }
  end

end
