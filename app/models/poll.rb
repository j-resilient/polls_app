class Poll < ApplicationRecord
    validates :author_id, presence: true
    validates :title, presence: true
    validates :title, uniqueness: { scope: :author_id }

    belongs_to :author,
        class_name: 'User',
        foreign_key: :author_id,
        primary_key: :id

    has_many :questions,
        class_name: 'Question',
        foreign_key: :poll_id,
        primary_key: :id
end