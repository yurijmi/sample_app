module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50, class: 'gravatar' })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    img_class = options[:class] || 'gravatar'
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: img_class)
  end
end
