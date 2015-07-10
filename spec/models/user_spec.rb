require 'rails_helper'

RSpec.describe User, type: :model do

  let(:dummy) { User.create!(email: 'example@example.com', username: 'dummy', password: 'pass') }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }
  it { should have_many(:questions) }
  it { should have_many(:answers) }
  it { should have_many(:votes) }
  it { should have_many(:comments) }

  context "as a user" do

    it "creates a user with a user name" do
      expect(dummy.username).to eq('dummy')
    end

    it "should have a password" do
      expect(dummy.password).to eq('pass')
    end

    it "has a hased password" do
      expect(dummy.password_digest).not_to eq('pass')
    end

    it "should have an email" do
      expect(dummy.email).to eq('example@example.com')
    end

  end
end
