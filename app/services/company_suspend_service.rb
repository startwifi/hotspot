class CompanySuspendService
  def initialize(company)
    @company = company
  end

  def call
    toggle_status_company
    toggle_status_admins
  end

  private

  def toggle_status_company
    @company.toggle(:active)
    @company.save
  end

  def toggle_status_admins
    @company.admins.each { |admin| change_status(admin) }
  end

  def change_status(user)
    user.toggle(:active)
    user.save
  end
end
