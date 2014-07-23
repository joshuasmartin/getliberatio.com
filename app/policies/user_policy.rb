class UserPolicy < Struct.new(:user, :record)
  def settings?
    update?
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    (user.id == record.id) || (user.is? "root")
  end

  def edit?
    update?
  end

  def destroy?
    user.is? "root"
  end
end
