class UserPolicy < ApplicationPolicy
  def index?
    # Only allow admin or users with roles to see the index (mirroring sales app logic)
    # For now, let's allow any logged in user to see it, or restrict to admin
    # Based on sales app: authorize current_user -> implies user must exist.
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user.present? && user.has_role?(:admin)
  end

  def new?
    create?
  end

  def update?
    user.present? && (user.has_role?(:admin) || user.id == record.id)
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && user.has_role?(:admin)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
