module CleanersHelper
  def get_full_name(cleaner)
    "#{cleaner.first_name} #{cleaner.last_name}"
  end
end
