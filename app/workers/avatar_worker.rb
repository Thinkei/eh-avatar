class AvatarWorker
  include Sidekiq::Worker

  def perform(avatar_id)
    avatar = Avatar[avatar_id]
    avatar.file_url = "tmp/#{SecureRandom.uuid}.png"
    generate_avatar(avatar.name, avatar.file_url)
    avatar.status = Avatar::STATUS_READY
    avatar.save
  end

  private

  def generate_avatar(name, file_url)
    canvas = Magick::ImageList.new
    canvas.new_image(300, 300)

    text = Magick::Draw.new
    text.pointsize = 52
    text.gravity = Magick::CenterGravity

    text.annotate(canvas, 0,0,2,2, name) {
      self.fill = 'gray83'
    }

    text.annotate(canvas, 0,0,-1.5,-1.5, name) {
      self.fill = 'gray40'
    }

    text.annotate(canvas, 0,0,0,0, name) {
      self.fill = Avatar::COLORS.sample
    }

    canvas.write(file_url)
    sleep 5
  end
end
