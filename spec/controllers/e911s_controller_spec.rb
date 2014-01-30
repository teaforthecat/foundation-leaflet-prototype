require 'spec_helper'

describe E911sController do
  login_user
  it_behaves_like "paginated"
end
