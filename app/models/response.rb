# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  answer_choice_id :integer          not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_responses_on_answer_choice_id  (answer_choice_id)
#  index_responses_on_user_id           (user_id)
#

class Response < ApplicationRecord
    validates :user_id, :answer_choice_id, presence: true
    validate :not_duplicate_response
    validate :not_author_response
    
    belongs_to :answer_choice,
        class_name: 'AnswerChoice',
        foreign_key: :answer_choice_id,
        primary_key: :id

    belongs_to :respondent,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id

    has_one :question, through: :answer_choice, source: :question

    # returns all sibling responses by calling #question on self
    # and then Question#responses on the result
    # and then filtering self out (because I am not my own sibling)
    def sibling_responses
        question.responses.where.not(id: self.id)
    end

    # checks to see if user has already answered the question
    # by checking to see if user has a response in sibing_responses
    def respondent_already_answered?
        sibling_responses.where('user_id = ?', self.user_id).exists?
    end

    def author_respondent?
        answer_choice.question.poll.author_id == self.user_id
    end

    private
    def not_duplicate_response
        if respondent_already_answered?
            errors[:user] << 'can only answer question once'
        end
    end

    # a validation that checks that the author isn't trying to answer their own poll
    # and rig the results
    def not_author_response
        if author_respondent?
            errors[:author] << 'cannot answer their own poll'
        end
    end
end
