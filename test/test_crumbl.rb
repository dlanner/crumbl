require 'minitest/autorun'
require 'crumbl'

class CrumblTest < Minitest::Unit::TestCase
  def setup
    @data = {:foo => "bar"}
    @key_base = "secret key base"
    @custom_iterations = 1001
    @custom_encrypted_cookie_salt = @custom_encrypted_signed_cookie_salt = "salty"
  end

  def test_decrypt_encrypted
    encrypted = Crumbl.new.encrypt(@data, @key_base)
    decrypted = Crumbl.new.decrypt(encrypted, @key_base)
    assert_equal @data, decrypted
  end

  def test_custom_iterations_equal
    crumbl = Crumbl.new do |opts|
      opts[:iterations]                   = @custom_iterations
      opts[:encrypted_cookie_salt]        = @custom_encrypted_cookie_salt
      opts[:encrypted_signed_cookie_salt] = @custom_encrypted_signed_cookie_salt
    end
    encrypted = crumbl.encrypt(@data, @key_base)
    decrypted = crumbl.decrypt(encrypted, @key_base)
    assert_equal @data, decrypted
  end

  def test_custom_iterations_not_equal
    encrypted = Crumbl.new.encrypt(@data, @key_base)
    assert_raises ActiveSupport::MessageVerifier::InvalidSignature do
      crumbl = Crumbl.new do |opts|
        opts[:iterations] = @custom_iterations
      end
      crumbl.decrypt(encrypted, @key_base)
    end
  end

  def test_custom_encrypted_cookie_salt_equal
    crumbl = Crumbl.new do |opts|
      opts[:encrypted_cookie_salt] = @custom_encrypted_cookie_salt
    end
    encrypted = crumbl.encrypt(@data, @key_base)
    decrypted = crumbl.decrypt(encrypted, @key_base)
    assert_equal @data, decrypted
  end

  def test_custom_encrypted_cookie_salt_not_equal
    encrypted = Crumbl.new.encrypt(@data, @key_base)
    assert_raises ActiveSupport::MessageEncryptor::InvalidMessage do
      crumbl = Crumbl.new do |opts|
        opts[:encrypted_cookie_salt] = @custom_encrypted_cookie_salt
      end
      crumbl.decrypt(encrypted, @key_base)
    end
  end

  def test_custom_encrypted_signed_cookie_salt_equal
    crumbl = Crumbl.new do |opts|
      opts[:encrypted_signed_cookie_salt] = @custom_encrypted_signed_cookie_salt
    end
    encrypted = crumbl.encrypt(@data, @key_base)
    decrypted = crumbl.decrypt(encrypted, @key_base)
    assert_equal @data, decrypted
  end

  def test_custom_encrypted_signed_cookie_salt_not_equal
    encrypted = Crumbl.new.encrypt(@data, @key_base)
    assert_raises ActiveSupport::MessageVerifier::InvalidSignature do
      crumbl = Crumbl.new do |opts|
        opts[:encrypted_signed_cookie_salt] = @custom_encrypted_signed_cookie_salt
      end
      crumbl.decrypt(encrypted, @key_base)
    end
  end
end