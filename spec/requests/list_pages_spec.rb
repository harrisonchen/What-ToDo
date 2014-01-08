require 'spec_helper'

describe "ListPages" do

	subject { page }

	describe "Lists pages" do

		let(:user) { FactoryGirl.create(:user) }
		let!(:list1) { FactoryGirl.create(:list, user: user, category: "Groceries") }
		let!(:list2) { FactoryGirl.create(:list, user: user, category: "Homework") }

		it { should have_link('Lists', href: lists_path) }

		before do
			visit signin_path
			sign_in user
			click_link('Lists')
		end

		it { should have_title('Lists') }

		describe "lists" do
			it { should have_content(list1.category) }
			it { should have_content(list2.category) }
		end

		describe "deleting a list" do
			before { click_link('Groceries') }

			it "should delete a category" do
				expect { click_link "delete" }.to change(List, :count).by(-1)
			end
		end
	end
end
