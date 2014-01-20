RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods


  config.after(:all) do
    if Rails.env.test?
      FileUtils.rm_rf(Dir["#{Rails.root}public/system/e911s"])
    end
  end
end
