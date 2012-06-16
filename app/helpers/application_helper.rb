module ApplicationHelper

	def format_datetime(time)
		time.strftime('%Y/%m/%d (%a) %H:%M') rescue ''
	end

	def linebreaksbr(text)
		return text.gsub(/\r\n\|\r|\n/, "<br />")
	end

end
