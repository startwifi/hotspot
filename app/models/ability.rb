class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Admin.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :read, User, company: user.company
      can :manage, [Fb, Vk, Tw], company: user.company
    end
  end
end
