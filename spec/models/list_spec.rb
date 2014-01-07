require 'spec_helper'

describe List do

	let(:user) { FactoryGirl.create(:user) }
	before do
		@list = user.lists.build(category: "Groceries")
	end

	subject { @list }

	it { should respond_to(:category) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	its(:user) { should eq user }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @list.user_id = nil }
		it { should_not be_valid }
	end

	describe "when category is not present" do
		before { @list.category = nil }
		it { should_not be_valid }
	end

	describe "with category that is too long" do
		before { @list.category = "a" * 51 }
		it { should_not be_valid }
	end

end
