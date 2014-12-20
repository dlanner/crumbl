require 'active_support/all'
require 'rack'

class Crumbl

  DEFAULT_ITERATIONS                   = 1000
  DEFAULT_ENCRYPTED_COOKIE_SALT        = "encrypted cookie"
  DEFAULT_ENCRYPTED_SIGNED_COOKIE_SALT = "signed encrypted cookie"

  attr_accessor :options

  def initialize
    @options = {}
    yield @options if block_given?
    options[:iterations]                   ||= DEFAULT_ITERATIONS
    options[:encrypted_cookie_salt]        ||= DEFAULT_ENCRYPTED_COOKIE_SALT
    options[:encrypted_signed_cookie_salt] ||= DEFAULT_ENCRYPTED_SIGNED_COOKIE_SALT
  end

  def decode cookie
    ::Rack::Session::Cookie::Base64::Marshal.new.decode(cookie)
  end

  def encode data, key
    cookie_verifier = ActiveSupport::MessageVerifier.new(key)
    cookie_verifier.generate data
  end

  def decrypt cookie, secret_key_base
    key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: options[:iterations])
    secret = key_generator.generate_key(options[:encrypted_cookie_salt])
    sign_secret = key_generator.generate_key(options[:encrypted_signed_cookie_salt])
    encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret)
    encryptor.decrypt_and_verify(cookie)
  end

  def encrypt data, secret_key_base
    key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: options[:iterations])
    secret = key_generator.generate_key(options[:encrypted_cookie_salt])
    sign_secret = key_generator.generate_key(options[:encrypted_signed_cookie_salt])
    encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret)
    encryptor.encrypt_and_sign(data)
  end
end