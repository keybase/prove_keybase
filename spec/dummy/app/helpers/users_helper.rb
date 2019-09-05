module UsersHelper
  def keybase_link(user)
    "keybase://profile/new-proof/#{ProveKeybase.configuration.domain}/#{user.username}"
  end
end
