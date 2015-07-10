require 'rails_helper'

RSpec.describe Question, type: :model do

  let(:dummy) { User.create!(email: 'example@example.com', username: 'dummy', password: 'pass') }
  let(:question){ dummy.questions.create(title: "Hello!", text: "Hello, world.") }

  it { should belong_to(:user) }
  it { should have_many(:answers) }
  it { should have_many(:votes) }
  it { should have_many(:comments) }

  it "should have a title" do
    expect(question.title).to eq("Hello!")
  end

  it "should have text" do
    expect(question.text).to eq("Hello, world.")
  end

  it "should belong to a user" do
    expect(question.user_id).to eq(dummy.id)
  end

  it "should belong to a user" do
    expect(question.user_id).to eq(dummy.id)
  end

# comment.commentable test the polymorphic association
  it "should be reffered to by its comment" do
    # expect(comment.commentable).to eq(question)
  end

end