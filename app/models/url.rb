class Url < ApplicationRecord

  validate :check_url
  after_save :make_short_url


	def make_short_url
		strip_url
		chars = ['0'..'9', 'A'..'Z', 'a'..'z'].map { |range| range.to_a }.flatten
		short = 6.times.map { chars.sample }.join
		Url.find_by_short_url(short).nil?
		update_column(:short_url, short)
		update_column(:url, self.url)
	end


	def check_url
		strip_url
		@url = Url.find_by_url(self.url)
		if @url.present?
			errors.add(:base, 'This Url is already present in database you can use its short url ')
			return false
		else
			puts "New url"
		end
	end

	def strip_url
		self.url.strip!
		self.url = self.url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
		self.url.slice!(-1) if self.url[-1] == "/"
		self.url = "http://#{self.url}"
	end


end
