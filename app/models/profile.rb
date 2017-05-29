class Profile < ApplicationRecord
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  SECURITY_QUESTIONS = ["What was your childhood nickname?", "What is the name of your favorite childhood friend?", "In what city or town did your mother and father meet?", "What is the middle name of your oldest child?", "What is your favorite team?", "What is your favorite movie?", "What was your favorite sport in high school?", "What was your favorite food as a child?", "What is the first name of the boy or girl that you first kissed?", "What was the make and model of your first car?", "What was the name of the hospital where you were born?", "Who is your childhood sports hero?", "What school did you attend for sixth grade?", "What was the last name of your third grade teacher?", "In what town was your first job?", "What was the name of the company where you had your first job?"]

  def is_completed?
    name.present? && company.present? && position.present?
  end
end
