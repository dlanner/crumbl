require 'active_support/all'
require 'rack'

module Crumbl

  DEFAULT_ITERATIONS                   = 1000
  DEFAULT_ENCRYPTED_COOKIE_SALT        = "encrypted cookie"
  DEFAULT_ENCRYPTED_SIGNED_COOKIE_SALT = "signed encrypted cookie"

  def self.decode cookie
    ::Rack::Session::Cookie::Base64::Marshal.new.decode(cookie)
  end

  def self.encode data, key
    cookie_verifier = ActiveSupport::MessageVerifier.new(key)
    cookie_verifier.generate data
  end

  def self.decrypt cookie, secret_key_base, iterations=DEFAULT_ITERATIONS, encrypted_cookie_salt=DEFAULT_ENCRYPTED_COOKIE_SALT, encrypted_signed_cookie_salt=DEFAULT_ENCRYPTED_SIGNED_COOKIE_SALT
    key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: iterations)
    secret = key_generator.generate_key(encrypted_cookie_salt)
    sign_secret = key_generator.generate_key(encrypted_signed_cookie_salt)
    encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret)
    encryptor.decrypt_and_verify(cookie)
  end

  def self.encrypt data, secret_key_base, iterations=DEFAULT_ITERATIONS, encrypted_cookie_salt=DEFAULT_ENCRYPTED_COOKIE_SALT, encrypted_signed_cookie_salt=DEFAULT_ENCRYPTED_SIGNED_COOKIE_SALT
    key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: iterations)
    secret = key_generator.generate_key(encrypted_cookie_salt)
    sign_secret = key_generator.generate_key(encrypted_signed_cookie_salt)
    encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret)
    encryptor.encrypt_and_sign(data)
  end
end