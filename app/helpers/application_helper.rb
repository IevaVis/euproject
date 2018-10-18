module ApplicationHelper


	def markdown_to_html(text)
		require 'kramdown'
		return Kramdown::Document.new(text, input: "GFM").to_html
	end
end
