module UsersHelper
  def gravatar_for user, options = { size: Settings.avatar_size }
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def find_relationship user_id
    current_user.active_relationships.find_by followed_id: user_id
  end

  def build_relationship
    current_user.active_relationships.build
  end
end
