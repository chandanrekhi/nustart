Paperclip::Attachment.interpolations[:startup_name] = proc do |attachment, style|
  attachment.instance.job.startup.name.downcase
end

Paperclip::Attachment.interpolations[:job_title] = proc do |attachment, style|
  attachment.instance.job.title.downcase
end

Paperclip::Attachment.interpolations[:email] = proc do |attachment, style|
  attachment.instance.email
end

# Paperclip.options[:image_magick_path] = '/opt/local/bin' 