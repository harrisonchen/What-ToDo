require 'spec_helper'

describe "StaticPages" do

	subject { page }

	describe "Home page" do
		
		before do
			visit root_path
		end

		it { should have_content('What-ToDo') }

		it { should have_title('What-ToDo') }
		it { should_not have_title('|') }
	end
end
