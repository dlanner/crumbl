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

  def test_custom_iterations_equal
    data = {:foo => "bar"}
    key_base = "secret key base"
    iterations = 1001
    encrypted = Crumbl.encrypt(data, key_base, iterations)
    decrypted = Crumbl.decrypt(encrypted, key_base, iterations)
    assert_equal data, decrypted
  end

  def test_custom_iterations_not_equal
    data = {:foo => "bar"}
    key_base = "secret key base"
    custom_iterations = 1001
    encrypted = Crumbl.encrypt(data, key_base)
    assert_raises ActiveSupport::MessageVerifier::InvalidSignature do
      Crumbl.decrypt(encrypted, key_base, custom_iterations)
    end
  end

  def test_custom_encrypted_cookie_salt
    data = {:foo => "bar"}
    key_base = "secret key base"
    custom_encrypted_cookie_salt = "salty"
    encrypted = Crumbl.encrypt(data, key_base)
    assert_raises ActiveSupport::MessageEncryptor::InvalidMessage do
      Crumbl.decrypt(encrypted, key_base, Crumbl::DEFAULT_ITERATIONS, custom_encrypted_cookie_salt)
    end
  end

  def test_custom_encrypted_signed_cookie_salt
    data = {:foo => "bar"}
    key_base = "secret key base"
    custom_encrypted_signed_cookie_salt = "salty"
    encrypted = Crumbl.encrypt(data, key_base)
    assert_raises ActiveSupport::MessageEncryptor::InvalidMessage do
      Crumbl.decrypt(encrypted, key_base, Crumbl::DEFAULT_ITERATIONS, custom_encrypted_signed_cookie_salt)
    end
  end
end