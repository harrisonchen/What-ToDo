module ApplicationHelper

	def full_title(page_title)
		base_title = "What-ToDo"
		if page_title.empty?
			base_title
		else
			"#{base_ttile} | #{page_title}"
		end
	end
end
