class Answer < ApplicationRecord
  belongs_to :question

  scope :correct, -> { where(correct: true) }

  validates :question_id, presence: true
  validates :body,        presence: true, length: { in: 3..256 }
  validates :correct,     inclusion: { in: [true, false] }
  validate :answer_is_less_then_fifth

  private
  def answer_is_less_then_fifth
    if question.answers.size > 4
      errors.add(:question, "question can't contain more then 4 answers")
    end
  end

end
