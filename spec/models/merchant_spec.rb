require 'rails_helper'

describe Merchant, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
end
#
# RSpec.describe Merchant, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
