require 'spec_helper'

describe "ListPages" do

	subject { page }

	describe "Lists pages" do
		before do
			visit signin_path
			signin_user
		end

		it { should have_link('Lists', href: lists_path) }

		describe "after clicking 'Lists'" do
			it { should have_title('Lists') }
			it { should have_content('Lists') }
		end
	end
end
