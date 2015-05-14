class User < ActiveRecord::Base
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password

  def self.is_first_user?
    User.count == 0
  end

  private
    def ensure_an_admin_remains
      if User.count.zero?
        raise "Cant't delete last user"
      end
    end
end