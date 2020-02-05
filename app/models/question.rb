# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  text       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  poll_id    :integer          not null
#
# Indexes
#
#  index_questions_on_poll_id  (poll_id)
#

class Question < ApplicationRecord
    validates :poll_id, :text, presence: true
    validates :poll_id, uniqueness: { scope: :text }
    validates_associated :answer_choices
    
    has_many :answer_choices,
        class_name: 'AnswerChoice',
        foreign_key: :question_id,
        primary_key: :id

    belongs_to :poll,
        class_name: 'Poll',
        foreign_key: :poll_id,
        primary_key: :id

    has_many :responses, 
        through: :answer_choices, 
        source: :responses

    def results
        # AnswerChoice.find_by_sql(<<-SQL)
        #     SELECT answer_choices.*, COUNT(responses.id) AS response_count
        #     FROM answer_choices
        #     LEFT JOIN responses ON answer_choices.id = responses.answer_choice_id
        #     WHERE answer_choices.question_id = #{self.id}
        #     GROUP BY answer_choices.id
        # SQL
        choices = AnswerChoice
            .select('answer_choices.*, COUNT(responses.id) AS response_count')
            .left_outer_joins(:responses)
            .where('answer_choices.question_id = ?', self.id)
            .group('answer_choices.id')
        results = {}
        choices.each do |answer|
            results[answer.text] = answer.response_count
        end
        results
    end
end
