class Option < ApplicationRecord
  validates_uniqueness_of :optionid
  validates_presence_of :title

  def self.get_distid
    return Option.find_by_optionid(1).value
  end

end
