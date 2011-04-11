require 'test_helper'

class PeticionMailerTest < ActionMailer::TestCase
  test "peticion_bicicleta" do
    @expected.subject = 'PeticionMailer#peticion_bicicleta'
    @expected.body    = read_fixture('peticion_bicicleta')
    @expected.date    = Time.now

    assert_equal @expected.encoded, PeticionMailer.create_peticion_bicicleta(@expected.date).encoded
  end

end
