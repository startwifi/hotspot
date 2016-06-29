class VkPhotoUploadService
  def initialize(company, token)
    @company = company
    @token = token
  end

  def call
    return unless @token
    upload_photo
  end

  private

  def upload_photo
    query = JSON.parse(RestClient.post(upload_url, file1: File.new(@company.vk.post_image.path)))
    RestClient.post('https://api.vk.com/method/photos.save', {
      access_token: @token,
      album_id: album_id,
      server: query['server'],
      photos_list: query['photos_list'],
      hash: query['hash'],
      # latitude: 48.461758,
      # longitude: 35.012707,
      caption: @company.vk.post_text
    })
    true
  rescue
    false
  end

  def album_id
    query = JSON.parse(RestClient.post('https://api.vk.com/method/photos.getAlbums', { access_token: @token }))
    @album_id ||= if query['response'][0]['title'].eql?(@company.name)
      query['response'][0]['aid']
    else
      query = JSON.parse(RestClient.post('https://api.vk.com/method/photos.createAlbum', { title: @company.name, description: @company.vk.post_text, access_token: @token }))
      query['response']['aid']
    end
  end

  def upload_url
    query = JSON.parse(RestClient.post('https://api.vk.com/method/photos.getUploadServer', { access_token: @token, album_id: album_id }))
    @upload_url ||= query['response']['upload_url']
  end
end
