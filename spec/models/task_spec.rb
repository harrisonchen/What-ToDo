require 'spec_helper'

describe Task do

	let(:list) { FactoryGirl.create(:list) }
	before do
		@task = Task.new(content: "homework", list_id: list.id)
	end

	subject { @task }

	it { should respond_to(:content) }
	it { should respond_to(:status) }
	it { should respond_to(:important) }
	it { should respond_to(:list_id) }
	it { should respond_to(:list) }
	its(:list) { should eq list }

	it { should be_valid }

	describe "when list_id is not present" do
		before { @task.list_id = nil }
		it { should_not be_valid }
	end

	describe "when content is not present" do
		before { @task.content = " " }
		it { should_not be_valid }
	end
	
	describe "with content that is too long" do
    	before { @task.content = "a" * 51 }
    	it { should_not be_valid }
  	end

end
