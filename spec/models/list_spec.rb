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

	describe "task associations" do
		before { @list.save }
		let!(:older_task) do
			FactoryGirl.create(:task, list: @list, created_at: 1.day.ago)
		end
		let!(:newer_task) do
			FactoryGirl.create(:task, list: @list, created_at: 1.hour.ago)
		end

		it "should have the right tasks in the right order" do
			expect(@list.tasks.to_a).to eq [newer_task, older_task]
		end

		it "should destory associated tasks" do
			tasks = @list.tasks.to_a
			@list.destroy
			expect(tasks).not_to be_empty
			tasks.each do |task|
				expect(Task.where(id: task.id)).to be_empty
			end
		end
	end

end
