require 'rails_helper'

describe Answer do
  it { should belong_to(:question) }
  it { should belong_to(:user) }

  it { should have_many(:comments) }
  it { should have_many(:votes) }

  it { should respond_to(:text) }
  it { should respond_to(:question_id) }
  it { should respond_to(:user_id) }
end
