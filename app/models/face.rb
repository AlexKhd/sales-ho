class Face < ApplicationRecord
  self.primary_key = "fid"

  validates_presence_of :dist_id, :ownerdist_id

  before_validation :check_dists
  before_save :set_fid

  private

    def check_dists
      self.dist_id = Option.get_distid unless self.dist_id.present?
      self.ownerdist_id = Option.get_distid unless self.ownerdist_id.present?
    end

    def set_fid
      # fids: 10000005 - sample with distid = 1 (5550000005 with 555)
      return if self.fid.present?
      max_id = Face.where(dist_id: Option.get_distid).maximum(:fid)
      if max_id && max_id > 1000
        self.fid = max_id + 1
      else # 1st record
        increment_str = "0000001"
        face_distid = Option.get_distid
        self.fid = "#{face_distid}#{increment_str}"
      end
    end
end
