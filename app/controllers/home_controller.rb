class HomeController < ApplicationController
  before_filter :authenticate_user!, :set_page_title

  def index
    assessment_results = AssessmentResult.all.order(start_date: :desc, value: :desc)

    all_start_date = assessment_results.pluck(:start_date).uniq
    all_end_date = assessment_results.pluck(:end_date).uniq

    @results = []
    all_start_date.each do |start_date|
      all_end_date.each do |end_date|
        result = assessment_results.select do |assessment_result|
          assessment_result.start_date == start_date &&
          assessment_result.end_date == end_date
        end

        if result.present?
          @results << {
            start_date: start_date,
            end_date: end_date,
            assessment_results: result
          }
        end
      end
    end
  end

private

  def set_page_title
    @page_title ||= 'Home'
  end

end