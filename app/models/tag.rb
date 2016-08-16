class Tag < ApplicationRecord

  TAG_COLORS = %w{default primary success info warning danger}

  belongs_to :paper

  enum color: Hash[TAG_COLORS.map{|x| [x,x]}]
end
