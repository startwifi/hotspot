require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  subject { ability }
  let(:ability) { Ability.new(user) }

  describe 'admin\'s abilities' do
    let(:company) { create(:company) }
    let(:user) { create(:admin, company: company) }

    context 'for companies' do
      let(:other_company) { create(:company) }

      it { expect(ability).to be_able_to(:read, company) }
      it { expect(ability).not_to be_able_to(:create, Company) }
      it { expect(ability).not_to be_able_to(:update, company) }
      it { expect(ability).not_to be_able_to(:destroy, company) }
      it { expect(ability).not_to be_able_to(:manage, other_company) }
    end

    context 'for admins' do
      let(:admin) { user }
      let(:other_admin) { create(:admin) }

      it { expect(ability).to be_able_to(:read, admin, admin: user) }
      it { expect(ability).not_to be_able_to(:create, Admin) }
      it { expect(ability).to be_able_to(:update, admin, user: user) }
      it { expect(ability).not_to be_able_to(:destroy, admin) }
      it { expect(ability).not_to be_able_to(:manage, other_admin) }
    end

    context 'for users (visitors)' do
      let(:visitor) { create(:user, company: company) }
      let(:other_visitor) { create(:user) }

      it { expect(ability).to be_able_to(:read, visitor, company: user.company) }
      it { expect(ability).not_to be_able_to(:create, User) }
      it { expect(ability).not_to be_able_to(:update, visitor) }
      it { expect(ability).not_to be_able_to(:destroy, visitor) }
      it { expect(ability).not_to be_able_to(:manage, other_visitor) }
    end

    context 'for events' do
      let(:event) { create(:event, company: company) }
      let(:other_event) { create(:event) }

      it { expect(ability).to be_able_to(:read, event) }
      it { expect(ability).not_to be_able_to(:create, Event) }
      it { expect(ability).not_to be_able_to(:update, event) }
      it { expect(ability).not_to be_able_to(:destroy, event) }
      it { expect(ability).not_to be_able_to(:manage, other_event) }
    end

    context 'for statistics' do
      let(:statistic) { create(:statistic, company: company) }
      let(:other_stat) { create(:statistic) }

      it { expect(ability).to be_able_to(:read, statistic) }
      it { expect(ability).not_to be_able_to(:create, Statistic) }
      it { expect(ability).not_to be_able_to(:update, statistic) }
      it { expect(ability).not_to be_able_to(:destroy, statistic) }
      it { expect(ability).not_to be_able_to(:manage, other_stat) }
    end

    context 'for facebook' do
      let(:fb) { create(:fb, company: company) }
      let(:other_fb) { create(:fb) }

      it { expect(ability).to be_able_to(:read, fb) }
      it { expect(ability).not_to be_able_to(:create, Fb) }
      it { expect(ability).to be_able_to(:update, fb) }
      it { expect(ability).not_to be_able_to(:destroy, fb) }
      it { expect(ability).not_to be_able_to(:manage, other_fb) }
    end

    context 'for twitter' do
      let(:tw) { create(:tw, company: company) }
      let(:other_tw) { create(:tw) }

      it { expect(ability).to be_able_to(:read, tw) }
      it { expect(ability).not_to be_able_to(:create, Tw) }
      it { expect(ability).to be_able_to(:update, tw) }
      it { expect(ability).not_to be_able_to(:destroy, tw) }
      it { expect(ability).not_to be_able_to(:manage, other_tw) }
    end

    context 'for vkontakte' do
      let(:vk) { create(:vk, company: company) }
      let(:other_vk) { create(:vk) }

      it { expect(ability).to be_able_to(:read, vk) }
      it { expect(ability).not_to be_able_to(:create, Vk) }
      it { expect(ability).to be_able_to(:update, vk) }
      it { expect(ability).not_to be_able_to(:destroy, vk) }
      it { expect(ability).not_to be_able_to(:manage, other_vk) }
    end

    context 'for instagram' do
      let(:ins) { create(:in, company: company) }
      let(:other_ins) { create(:in) }

      it { expect(ability).to be_able_to(:read, ins) }
      it { expect(ability).not_to be_able_to(:create, In) }
      it { expect(ability).to be_able_to(:update, ins) }
      it { expect(ability).not_to be_able_to(:destroy, ins) }
      it { expect(ability).not_to be_able_to(:manage, other_ins) }
    end

    context 'for odnoklassniki' do
      let(:ok) { create(:ok, company: company) }
      let(:other_ok) { create(:ok) }

      it { expect(ability).to be_able_to(:read, ok) }
      it { expect(ability).not_to be_able_to(:create, Ok) }
      it { expect(ability).to be_able_to(:update, ok) }
      it { expect(ability).not_to be_able_to(:destroy, ok) }
      it { expect(ability).not_to be_able_to(:manage, other_ok) }
    end
  end

  describe 'global admin\'s abilities' do
    let(:user) { create(:admin, admin: true) }

    context 'for companies' do
      let(:company) { create(:company) }

      it { expect(ability).to be_able_to(:read, company) }
      it { expect(ability).to be_able_to(:create, Company) }
      it { expect(ability).to be_able_to(:update, company) }
      it { expect(ability).to be_able_to(:destroy, company) }
    end

    context 'for admins' do
      let(:admin) { create(:admin) }

      it { expect(ability).to be_able_to(:read, admin) }
      it { expect(ability).to be_able_to(:create, Admin) }
      it { expect(ability).to be_able_to(:update, admin) }
      it { expect(ability).to be_able_to(:destroy, admin) }
    end

    context 'for users (visitors)' do
      let(:visitor) { create(:user) }

      it { expect(ability).to be_able_to(:read, visitor) }
      it { expect(ability).to be_able_to(:create, User) }
      it { expect(ability).to be_able_to(:update, visitor) }
      it { expect(ability).to be_able_to(:destroy, visitor) }
    end

    context 'for events' do
      let(:event) { create(:event) }

      it { expect(ability).to be_able_to(:read, event) }
      it { expect(ability).to be_able_to(:create, Event) }
      it { expect(ability).to be_able_to(:update, event) }
      it { expect(ability).to be_able_to(:destroy, event) }
    end

    context 'for statistics' do
      let(:statistic) { create(:statistic) }

      it { expect(ability).to be_able_to(:read, statistic) }
      it { expect(ability).to be_able_to(:create, Statistic) }
      it { expect(ability).to be_able_to(:update, statistic) }
      it { expect(ability).to be_able_to(:destroy, statistic) }
    end

    context 'for facebook' do
      let(:fb) { create(:fb) }

      it { expect(ability).to be_able_to(:read, fb) }
      it { expect(ability).to be_able_to(:create, Fb) }
      it { expect(ability).to be_able_to(:update, fb) }
      it { expect(ability).to be_able_to(:destroy, fb) }
    end

    context 'for twitter' do
      let(:tw) { create(:tw) }

      it { expect(ability).to be_able_to(:read, tw) }
      it { expect(ability).to be_able_to(:create, Tw) }
      it { expect(ability).to be_able_to(:update, tw) }
      it { expect(ability).to be_able_to(:destroy, tw) }
    end

    context 'for vkontakte' do
      let(:vk) { create(:vk) }

      it { expect(ability).to be_able_to(:read, vk) }
      it { expect(ability).to be_able_to(:create, Vk) }
      it { expect(ability).to be_able_to(:update, vk) }
      it { expect(ability).to be_able_to(:destroy, vk) }
    end

    context 'for instagram' do
      let(:ins) { create(:in) }

      it { expect(ability).to be_able_to(:read, ins) }
      it { expect(ability).to be_able_to(:create, In) }
      it { expect(ability).to be_able_to(:update, ins) }
      it { expect(ability).to be_able_to(:destroy, ins) }
    end

    context 'for odnoklassniki' do
      let(:ok) { create(:ok) }

      it { expect(ability).to be_able_to(:read, ok) }
      it { expect(ability).to be_able_to(:create, Ok) }
      it { expect(ability).to be_able_to(:update, ok) }
      it { expect(ability).to be_able_to(:destroy, ok) }
    end
  end

  describe 'guest\'s abilities' do
    let(:user) { nil }

    context 'for companies' do
      let(:company) { create(:company) }

      it { expect(ability).not_to be_able_to(:read, company) }
      it { expect(ability).not_to be_able_to(:create, Company) }
      it { expect(ability).not_to be_able_to(:update, company) }
      it { expect(ability).not_to be_able_to(:destroy, company) }
    end

    context 'for admins' do
      let(:admin) { create(:admin) }

      it { expect(ability).not_to be_able_to(:read, admin) }
      it { expect(ability).not_to be_able_to(:create, Admin) }
      it { expect(ability).not_to be_able_to(:update, admin) }
      it { expect(ability).not_to be_able_to(:destroy, admin) }
    end

    context 'for users (visitors)' do
      let(:visitor) { create(:user) }

      it { expect(ability).not_to be_able_to(:read, visitor) }
      it { expect(ability).not_to be_able_to(:create, User) }
      it { expect(ability).not_to be_able_to(:update, visitor) }
      it { expect(ability).not_to be_able_to(:destroy, visitor) }
    end

    context 'for events' do
      let(:event) { create(:event) }

      it { expect(ability).not_to be_able_to(:read, event) }
      it { expect(ability).not_to be_able_to(:create, Event) }
      it { expect(ability).not_to be_able_to(:update, event) }
      it { expect(ability).not_to be_able_to(:destroy, event) }
    end

    context 'for statistics' do
      let(:statistic) { create(:statistic) }

      it { expect(ability).not_to be_able_to(:read, statistic) }
      it { expect(ability).not_to be_able_to(:create, Statistic) }
      it { expect(ability).not_to be_able_to(:update, statistic) }
      it { expect(ability).not_to be_able_to(:destroy, statistic) }
    end

    context 'for facebook' do
      let(:fb) { create(:fb) }

      it { expect(ability).not_to be_able_to(:read, fb) }
      it { expect(ability).not_to be_able_to(:create, Fb) }
      it { expect(ability).not_to be_able_to(:update, fb) }
      it { expect(ability).not_to be_able_to(:destroy, fb) }
    end

    context 'for twitter' do
      let(:tw) { create(:tw) }

      it { expect(ability).not_to be_able_to(:read, tw) }
      it { expect(ability).not_to be_able_to(:create, Tw) }
      it { expect(ability).not_to be_able_to(:update, tw) }
      it { expect(ability).not_to be_able_to(:destroy, tw) }
    end

    context 'for vkontakte' do
      let(:vk) { create(:vk) }

      it { expect(ability).not_to be_able_to(:read, vk) }
      it { expect(ability).not_to be_able_to(:create, Vk) }
      it { expect(ability).not_to be_able_to(:update, vk) }
      it { expect(ability).not_to be_able_to(:destroy, vk) }
    end

    context 'for instagram' do
      let(:ins) { create(:in) }

      it { expect(ability).not_to be_able_to(:read, ins) }
      it { expect(ability).not_to be_able_to(:create, In) }
      it { expect(ability).not_to be_able_to(:update, ins) }
      it { expect(ability).not_to be_able_to(:destroy, ins) }
    end

    context 'for odnoklassniki' do
      let(:ok) { create(:ok) }

      it { expect(ability).not_to be_able_to(:read, ok) }
      it { expect(ability).not_to be_able_to(:create, Ok) }
      it { expect(ability).not_to be_able_to(:update, ok) }
      it { expect(ability).not_to be_able_to(:destroy, ok) }
    end
  end
end
