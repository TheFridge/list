require 'test_helper'

class CupboardTest < ActiveSupport::TestCase
  def test_cupboard_must_have_user_id
    cupboards(:one).update(user_id: nil)
    refute cupboards(:one).valid?  
  end
end
