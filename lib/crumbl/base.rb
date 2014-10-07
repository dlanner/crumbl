require 'active_support/all'
require 'rack'

class Crumbl

  DEFAULT_ITERATIONS                   = 1000
  DEFAULT_ENCRYPTED_COOKIE_SALT        = "encrypted cookie"
  DEFAULT_ENCRYPTED_SIGNED_COOKIE_SALT = "signed encrypted cookie"

  def self.decode cookie
    decoded = ::Rack::Session::Cookie::Base64::Marshal.new.decode(cookie)
    puts "Decoded: #{decoded}"
  end

  def self.encode data, key
    cookie_verifier = ActiveSupport::MessageVerifier.new(key)
    encoded = cookie_verifier.generate data
    puts "Encoded: #{encoded}"
  end

  def self.decrypt cookie, secret_key_base, iterations=DEFAULT_ITERATIONS, encrypted_cookie_salt=DEFAULT_ENCRYPTED_COOKIE_SALT, encrypted_signed_cookie_salt=DEFAULT_ENCRYPTED_SIGNED_COOKIE_SALT
    key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: iterations)
    secret = key_generator.generate_key(encrypted_cookie_salt)
    sign_secret = key_generator.generate_key(encrypted_signed_cookie_salt)
    encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret)
    decrypted = encryptor.decrypt_and_verify(cookie)
    puts "Decrypted: #{decrypted}"
  end

  def self.encrypt data, secret_key_base, iterations=DEFAULT_ITERATIONS, encrypted_cookie_salt=DEFAULT_ENCRYPTED_COOKIE_SALT, encrypted_signed_cookie_salt=DEFAULT_ENCRYPTED_SIGNED_COOKIE_SALT
    key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: iterations)
    secret = key_generator.generate_key(encrypted_cookie_salt)
    sign_secret = key_generator.generate_key(encrypted_signed_cookie_salt)
    encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret)
    encrypted = encryptor.encrypt_and_sign(data)
    puts "Encrypted: #{encrypted}"
  end
end