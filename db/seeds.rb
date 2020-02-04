# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('polls')
ActiveRecord::Base.connection.reset_pk_sequence!('questions')
ActiveRecord::Base.connection.reset_pk_sequence!('answer_choices')
ActiveRecord::Base.connection.reset_pk_sequence!('responses')

users = User.create([
    { username: 'apple' }, { username: 'banana' }, 
    { username: 'canteloupe' }, { username: 'pear' }, 
    { username: 'kiwi' }
])

polls = Poll.create([
    { author_id: users[0].id, title: 'ohio' },
    { author_id: users[0].id, title: 'iowa' },
    { author_id: users[1].id, title: 'new york' },
    { author_id: users[2].id, title: 'maine' }
])

questions = Question.create([
    { poll_id: polls[0].id, text: 'Zero' },
    { poll_id: polls[2].id, text: 'Zero' },
    { poll_id: polls[2].id, text: 'One' },
    { poll_id: polls[2].id, text: 'Two' },
    { poll_id: polls[2].id, text: 'Three' },
    { poll_id: polls[3].id, text: 'Zero' },
    { poll_id: polls[3].id, text: 'One' },
    { poll_id: polls[3].id, text: 'Two' },
])

answer_choices = AnswerChoice.create([
    { question_id: questions[0].id, text: 'a' },
    { question_id: questions[0].id, text: 'b' },
    { question_id: questions[0].id, text: 'c' },
    { question_id: questions[1].id, text: 'd' },
    { question_id: questions[1].id, text: 'e' },
    { question_id: questions[2].id, text: 'f' },
    { question_id: questions[2].id, text: 'g' },
    { question_id: questions[2].id, text: 'h' },
    { question_id: questions[2].id, text: 'i' },
    { question_id: questions[3].id, text: 'a' },
    { question_id: questions[3].id, text: 'b' },
    { question_id: questions[4].id, text: 'z' },
    { question_id: questions[4].id, text: 'y' },
    { question_id: questions[4].id, text: 'x' },
    { question_id: questions[5].id, text: 'j' },
    { question_id: questions[5].id, text: 'k' },
    { question_id: questions[6].id, text: 'd' },
    { question_id: questions[6].id, text: 'x' },
    { question_id: questions[6].id, text: 'a' },
    { question_id: questions[7].id, text: 'a' },
    { question_id: questions[7].id, text: 'z' },
])

Response.create([
    { user_id: users[4].id, answer_choice_id: answer_choices[1].id },
    { user_id: users[4].id, answer_choice_id: answer_choices[4].id },
    { user_id: users[4].id, answer_choice_id: answer_choices[6].id },
    { user_id: users[4].id, answer_choice_id: answer_choices[9].id },
    { user_id: users[4].id, answer_choice_id: answer_choices[13].id },
    { user_id: users[4].id, answer_choice_id: answer_choices[14].id },
    { user_id: users[4].id, answer_choice_id: answer_choices[18].id },
    { user_id: users[1].id, answer_choice_id: answer_choices[2].id },
    { user_id: users[2].id, answer_choice_id: answer_choices[2].id },
    { user_id: users[3].id, answer_choice_id: answer_choices[2].id },
])