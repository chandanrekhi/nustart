module SqlCondition
  class Job
    class << self
      # def not_expired
      #   [ "state = ? or state = ? or state = ?", "created", "twittered", "renewed" ]
      # end
      def not_expired_by_industry(industry)
        [ "industry_id = ? and (state = ? or state = ? or state = ?)", industry, "created", "twittered", "renewed" ]
      end
    end
  end
end