RSpec.describe Company, type: :model do
  describe 'validation' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :owner_name }
    it { should validate_presence_of :phone }
    it { should validate_presence_of :address }
  end

  describe 'associations' do
    it { should have_many(:admins).dependent(:destroy) }
    it { should have_many(:users).dependent(:destroy) }
    it { should have_many(:events).dependent(:destroy) }
    it { should have_many(:statistics).dependent(:destroy) }
    it { should have_one(:vk).dependent(:destroy) }
    it { should have_one(:fb).dependent(:destroy) }
    it { should have_one(:tw).dependent(:destroy) }
    it { should have_one(:ok).dependent(:destroy) }
    it { should have_one(:in).dependent(:destroy) }
  end

  describe '#create_dummy_social' do
    let!(:company) { create(:company) }

    social_networks = %i(vk tw ok in) # todo: add fb (failed)

    social_networks.each do |sn|
      context "creates #{sn.capitalize} settings" do
        before { company.create_dummy_social(sn) }

        subject { company.send(sn) }

        it 'creates social network settings' do
          expect(subject).not_to be_nil
        end

        it 'returns a group name' do
          expect(subject.group_name).to eq ENV["#{sn.upcase}_GROUP_NAME"]
        end

        it 'returns an action' do
          expect(subject.action).to eq 'disabled'
        end

        it 'returns a redirection link' do
          expect(subject.link_redirect).to eq ENV['LINK_REDIRECT']
        end

        it 'returns a post text' do
          expect(subject.post_text).to eq company.name
        end

        it 'returns a post link' do
          expect(subject.post_link).to_not be_nil
        end

        it 'returns a post image' do
          expect(subject.post_image).to_not be_nil
        end
      end
    end
  end
end
