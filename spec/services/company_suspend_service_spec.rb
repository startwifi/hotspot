describe CompanySuspendService do
  let!(:company) { create(:company) }
  let!(:first_admin) { create(:admin, company: company) }
  let!(:second_admin) { create(:admin, company: company) }

  describe '#call' do
    it 'should toggle company status' do
      expect(company.active).to be_truthy
      CompanySuspendService.new(company).call
      expect(company.active).to be_falsy
      CompanySuspendService.new(company).call
      expect(company.active).to be_truthy
    end

    it 'should toggle admins status' do
      expect(company.admins.first.active).to be_truthy
      expect(company.admins.last.active).to be_truthy
      CompanySuspendService.new(company).call
      expect(company.admins.first.active).to be_falsy
      expect(company.admins.last.active).to be_falsy
      CompanySuspendService.new(company).call
      expect(company.admins.first.active).to be_truthy
      expect(company.admins.last.active).to be_truthy
    end
  end
end
