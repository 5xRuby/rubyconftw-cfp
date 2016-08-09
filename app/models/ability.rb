class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    can :manage, Paper, user_id: user.id
    can :read, Activity

    if user.is_admin?
      can :read, Paper
    end

  end
end
