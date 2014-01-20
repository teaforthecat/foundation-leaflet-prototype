require 'spec_helper'

describe E911 do
  it 'counts the subscribers being created' do
    e911 = create(:e911)
    e911.subscriber_list_row_count.should eq(1)
    E911.where(subscriber_list_row_count: 1).count.should_not be_zero
  end

end
