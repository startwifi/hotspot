describe DummySocialService do
  let!(:company) { create(:company) }

  describe '#call' do
    before do
      DummySocialService.new(company, :fb, :vk, :tw, :in, :ok).call
    end

    it 'creates fb' do
      expect(company.fb.group_name).to eq Figaro.env.fb_group_name
      expect(company.fb.action).to eq 'disabled'
      expect(company.fb.link_redirect).to eq Figaro.env.link_redirect
      expect(company.fb.post_text).to eq company.name
      expect(company.fb.post_link).to eq "https://facebook.com/#{Figaro.env.fb_group_name}"
    end

    it 'creates vk' do
      expect(company.vk.group_name).to eq Figaro.env.vk_group_name
      expect(company.vk.action).to eq 'disabled'
      expect(company.vk.link_redirect).to eq Figaro.env.link_redirect
      expect(company.vk.post_text).to eq company.name
      expect(company.vk.post_link).to eq "https://vk.com/#{Figaro.env.vk_group_name}"
    end

    it 'creates tw' do
      expect(company.tw.group_name).to eq Figaro.env.tw_group_name
      expect(company.tw.action).to eq 'disabled'
      expect(company.tw.link_redirect).to eq Figaro.env.link_redirect
      expect(company.tw.post_text).to eq company.name
      expect(company.tw.post_link).to eq "https://twitter.com/#{Figaro.env.tw_group_name}"
    end

    it 'creates in' do
      expect(company.in.group_name).to eq Figaro.env.in_group_name
      expect(company.in.action).to eq 'disabled'
      expect(company.in.link_redirect).to eq Figaro.env.link_redirect
      expect(company.in.post_text).to eq company.name
      expect(company.in.post_link).to eq "https://instagram.com/#{Figaro.env.in_group_name}"
    end

    it 'creates ok' do
      expect(company.ok.group_name).to eq Figaro.env.ok_group_name
      expect(company.ok.action).to eq 'disabled'
      expect(company.ok.link_redirect).to eq Figaro.env.link_redirect
      expect(company.ok.post_text).to eq company.name
      expect(company.ok.post_link).to eq "https://ok.ru/group/#{Figaro.env.ok_group_name}"
    end
  end
end
