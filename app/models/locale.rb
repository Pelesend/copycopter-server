class Locale < ActiveRecord::Base
  belongs_to :project
  has_many :localizations, :dependent => :destroy

  validates_presence_of :key, :project_id
  validates_uniqueness_of :key, :scope => :project_id

  # https://github.com/copycopter/copycopter-server/issues/64
  def self.enabled_in_order
    enabled.order(:key)
  end

  def self.first_enabled
    order(:created_at).enabled.first
  end

  private

  def self.enabled
    where :enabled => true
  end
end
