require 'minitest/autorun'
require 'crumbl'

class CrumblTest < Minitest::Test
  def test_decrypt_encrypted
    data = {:foo => "bar"}
    key_base = "secret key base"
    encrypted = Crumbl.encrypt(data, key_base)
    decrypted = Crumbl.decrypt(encrypted, key_base)
    assert_equal data, decrypted
  end
end