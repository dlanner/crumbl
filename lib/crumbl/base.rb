require 'active_support/all'

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
    Marshal.load(Base64.decode64(cookie))
  end

  def encode data, key
    cookie_verifier = ActiveSupport::MessageVerifier.new(key)
    cookie_verifier.generate data
  end

  def decrypt cookie, secret_key_base
    encryptor = build_message_encryptor(secret_key_base)
    encryptor.decrypt_and_verify(CGI.unescape(cookie))
  end

  def encrypt data, secret_key_base
    encryptor = build_message_encryptor(secret_key_base)
    encryptor.encrypt_and_sign(data.to_s)
  end

  private

  def build_message_encryptor secret_key_base
    key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: options[:iterations])
    secret        = key_generator.generate_key(options[:encrypted_cookie_salt])
    sign_secret   = key_generator.generate_key(options[:encrypted_signed_cookie_salt])
    ActiveSupport::MessageEncryptor.new(secret, sign_secret, serializer: ActiveSupport::MessageEncryptor::NullSerializer)
  end

end

class String
  def is_json?
    !!JSON.parse(self) rescue false
  end
end
