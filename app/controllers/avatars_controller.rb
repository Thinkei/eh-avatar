class AvatarsController < Sinatra::Base
  get '/avatars/:id' do
    avatar = Avatar[params['id']]

    if avatar.ready?
      send_file avatar.file_url
    else
      avatar.status
    end
  end

  post '/avatars' do
    avatar = Avatar.create(
      name: params['name'],
      status: Avatar::STATUS_PENDING
    )
    AvatarWorker.perform_async(avatar.id)

    status 201
    "http://localhost:9292/avatars/#{avatar.id}"
  end
end
