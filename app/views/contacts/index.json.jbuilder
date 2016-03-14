json.array!(@contacts) do |contact|
  json.extract! contact, :id, :first, :last, :title, :city, :phone, :email
  json.url contact_url(contact, format: :json)
end
