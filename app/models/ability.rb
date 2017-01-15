class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is_a?(Admin) && user.admin?
      can :manage, :all
    elsif user.is_a?(Admin)
      can [:read, :update], [Fb, Tw, Vk, In, Ok, Sms, Guest], company_id: user.company.id
      can [:read, :update], Admin, company_id: user.company.id
      can :read, Company, id: user.company.id
      can :read, User, company_id: user.company.id
      can :read, Event, company_id: user.company.id
      can :read, Statistic, company_id: user.company.id
      can :read, Device, company_id: user.company.id
      can :manage, Router do |router|
        router.company == user.company
      end 
    else
      can :read, Agreement
    end
  end
end
