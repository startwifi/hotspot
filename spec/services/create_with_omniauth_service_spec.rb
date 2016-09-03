describe CreateWithOmniauthService do
  let!(:company) { create(:company) }
  let!(:auth) { auth_mock_vkontakte }

  describe '#parse_vk_bdate' do
    it 'should return nil if bdate nil' do
      auth.extra.raw_info.bdate = nil
      service = CreateWithOmniauthService.new(company, auth)
      expect(service.send(:parse_vk_bdate)).to be_nil
    end

    it 'should return full date if persist' do
      auth.extra.raw_info.bdate = '12.11.1988'
      service = CreateWithOmniauthService.new(company, auth)
      expect(service.send(:parse_vk_bdate)).to match Date.new(1988, 11, 12)
    end

    it 'should return date with 1912 year if year is not present in bday' do
      auth.extra.raw_info.bdate = '12.11'
      service = CreateWithOmniauthService.new(company, auth)
      expect(service.send(:parse_vk_bdate)).to match Date.new(1912, 11, 12)
    end
  end
end
