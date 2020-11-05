class Story < ApplicationRecord
  MEDIA_PATH = Rails.env.test? ? 'spec/fixtures/media' : 'import/media'

  has_many :speaker_stories, inverse_of: :story
  has_many :speakers, through: :speaker_stories
  has_many_attached :media
  has_and_belongs_to_many :places
  belongs_to :interview_location, class_name: "Place", foreign_key: "interview_location_id", optional: true
  belongs_to :interviewer, class_name: "Speaker", foreign_key: "interviewer_id", optional: true
  has_many :media_links

  validates_presence_of :speakers, message: ': Your story must have at least one Speaker'

  def self.import_csv(file_contents)
    ApplicationController.helpers.csv_importer(file_contents, self)
  end


  enum permission_level: [:anonymous, :user_only, :editor_only]
end
 