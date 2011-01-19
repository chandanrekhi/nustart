class UserSweeper < ActionController::Caching::Sweeper
  
  observe User
  
  def after_save(user)
    clear_users_cache(user)
  end
  
  def clear_users_cache(user)
    expire_fragment(%r{startups/list_by_letter/.*})
    expire_fragment(%r{startups.*})
  end
  
end