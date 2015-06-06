class HomeController < ApplicationController
  before_filter :authenticate_user!, :set_page_title

  def index
    @results = []

    assessment_ranges = AssessmentRange.active.order(updated_at: :desc)
    assessment_ranges.each do |assessment_range|
      assessment_results = AssessmentResult.where(assessment_range_id: assessment_range.id)
                                           .order(weighting_value: :desc, average_value: :desc)
      @results << {
        start_date: assessment_range.start_date,
        end_date: assessment_range.end_date,
        assessment_results: assessment_results
      }
    end
  end

private

  def set_page_title
    @page_title ||= 'Home'
  end

end