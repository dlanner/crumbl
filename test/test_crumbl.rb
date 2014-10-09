require 'minitest/autorun'
require 'crumbl'

class CrumblTest < Minitest::Unit::TestCase
  def setup
    @data = {:foo => "bar"}
    @formatted_data = @data.map { |k,v| "#{k}:\"#{v}\"" }.join(" ")
    @key_base = "secret key base"
    @custom_iterations = 1001
    @custom_encrypted_cookie_salt = @custom_encrypted_signed_cookie_salt = "salty"
  end

  def test_decrypt_encrypted
    encrypted = Crumbl.encrypt(@data, @key_base)
    decrypted = Crumbl.decrypt(encrypted, @key_base)
    assert_equal @data, decrypted
  end

  def test_executable_decrypt_encrypted
    encrypted = `./bin/crumbl encrypt "#{@key_base}" --data "#{@formatted_data}"`
    decrypted = `./bin/crumbl decrypt "#{@key_base}" #{encrypted}`
    decrypted = eval(decrypted)
    decrypted = ActiveSupport::HashWithIndifferentAccess.new(decrypted)
    data = ActiveSupport::HashWithIndifferentAccess.new(@data)
    assert_equal data, decrypted
  end

  def test_custom_iterations_equal
    encrypted = Crumbl.encrypt(@data, @key_base, @custom_iterations)
    decrypted = Crumbl.decrypt(encrypted, @key_base, @custom_iterations)
    assert_equal @data, decrypted
  end

  def test_custom_iterations_not_equal
    encrypted = Crumbl.encrypt(@data, @key_base)
    assert_raises ActiveSupport::MessageVerifier::InvalidSignature do
      Crumbl.decrypt(encrypted, @key_base, @custom_iterations)
    end
  end

  def test_custom_encrypted_cookie_salt_equal
    encrypted = Crumbl.encrypt(@data, @key_base, Crumbl::DEFAULT_ITERATIONS, @custom_encrypted_cookie_salt)
    decrypted = Crumbl.decrypt(encrypted, @key_base, Crumbl::DEFAULT_ITERATIONS, @custom_encrypted_cookie_salt)
    assert_equal @data, decrypted
  end

  def test_custom_encrypted_cookie_salt_not_equal
    encrypted = Crumbl.encrypt(@data, @key_base)
    assert_raises ActiveSupport::MessageEncryptor::InvalidMessage do
      Crumbl.decrypt(encrypted, @key_base, Crumbl::DEFAULT_ITERATIONS, @custom_encrypted_cookie_salt)
    end
  end

  def test_custom_encrypted_signed_cookie_salt_equal
    encrypted = Crumbl.encrypt(@data, @key_base, Crumbl::DEFAULT_ITERATIONS, Crumbl::DEFAULT_ENCRYPTED_COOKIE_SALT, @custom_encrypted_signed_cookie_salt)
    decrypted = Crumbl.decrypt(encrypted, @key_base, Crumbl::DEFAULT_ITERATIONS, Crumbl::DEFAULT_ENCRYPTED_COOKIE_SALT, @custom_encrypted_signed_cookie_salt)
    assert_equal @data, decrypted
  end

  def test_custom_encrypted_signed_cookie_salt_not_equal
    encrypted = Crumbl.encrypt(@data, @key_base)
    assert_raises ActiveSupport::MessageVerifier::InvalidSignature do
      Crumbl.decrypt(encrypted, @key_base, Crumbl::DEFAULT_ITERATIONS, Crumbl::DEFAULT_ENCRYPTED_COOKIE_SALT, @custom_encrypted_signed_cookie_salt)
    end
  end
end