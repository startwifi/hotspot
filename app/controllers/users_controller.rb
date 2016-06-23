# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  birthday   :date
#  url        :string
#  company_id :integer
#  email      :string
#  gender     :string
#
# Indexes
#
#  index_users_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_7682a3bdfe  (company_id => companies.id)
#

class UsersController < ApplicationController
  before_filter :authenticate_admin!
  load_and_authorize_resource

  def index
    @q = @users.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def show
  end

end
