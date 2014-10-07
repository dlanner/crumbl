require 'active_support/all'

class RailsCookie

  def self.decode cookie, key
    cookie_verifier = ActiveSupport::MessageVerifier.new(key)
    decoded = cookie_verifier.verify URI.unescape(cookie)
    puts "Decoded: #{decoded}"
  end

  def self.encode data, key
    cookie_verifier = ActiveSupport::MessageVerifier.new(key)
    encoded = cookie_verifier.generate data
    puts "Encoded: #{encoded}"
  end

  def self.decrypt cookie, secret_key_base, iterations=1000, encrypted_cookie_salt="encrypted cookie", encrypted_signed_cookie_salt="signed encrypted cookie"
    key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: iterations)
    secret = key_generator.generate_key(encrypted_cookie_salt)
    sign_secret = key_generator.generate_key(encrypted_signed_cookie_salt)
    encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret)
    decrypted = encryptor.decrypt_and_verify(message)
    puts "Decrypted: #{decrypted}"
  end
end