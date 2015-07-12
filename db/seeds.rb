# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
number_of_users = 10
max_number_of_random_questions = 5
max_number_of_random_answers = 5
max_number_of_random_comments = 5
max_number_of_random_votes = 5

def add_comments(target, number_of_comments)
  user_pool = (1..10).to_a # should link this to number_of_users later
  user_pool.delete(target.user_id)

  number_of_comments.times do
    comment = target.comments.build(text: Faker::Lorem.sentences(rand(1..5)).join(" "), user_id: user_pool.sample)
    comment.save
  end
end

def add_votes(target, number_of_votes)
  user_pool = (1..10).to_a # should link this to number_of_users later
  user_pool.delete(target.user_id)

  number_of_votes.times do
    vote = target.votes.build(user_id: user_pool.sample)
    vote.save
  end

  target.total = rand(1..number_of_votes)

  if rand(1..2) == 2
    target.total *= -1
  end

  target.save
end

def add_answers(question, number_of_answers)
  user_pool = (1..10).to_a # should link this to number_of_users later
  user_pool.delete(question.user_id)

  number_of_answers.times do
    answer = question.answers.build(text: Faker::Lorem.sentences(rand(1..5)).join(" "), user_id: user_pool.sample)
    answer.save

    add_comments(answer, rand(1..5))
    add_votes(answer, rand(1..5))
  end
end

number_of_users.times do
  first_name = Faker::Name.first_name
  User.create(username: first_name, email: "#{first_name}@example.com", password: '123', bio: Faker::Lorem.paragraphs(rand(1..5)).join("\n"))
end

User.all.each do |user|
  rand(1..max_number_of_random_questions).times do
    question = user.questions.build(title: Faker::Lorem.sentence, text: Faker::Lorem.paragraphs(rand(1..5)).join("\n"))
    question.save

    add_comments(question, rand(1..max_number_of_random_comments))
    add_votes(question, rand(1..max_number_of_random_votes))

    add_answers(question, rand(1..max_number_of_random_answers))
  end
end
