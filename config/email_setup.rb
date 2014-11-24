ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "pricesir.com",
  :user_name            => "mothirajha.chandramohan@desidime.com",
  :password             => "mothirajha12",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "seotool.com"