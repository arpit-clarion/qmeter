require 'fileutils'

module Qmeter
  class ReportController < ::ApplicationController

  	# GET::report#index
  	# localhost:3000/qmeter
    def index
    	thresholds = {}
	  	thresholds['security_warnings_min'] = 1
	  	thresholds['security_warnings_max'] = 100
	  	
	  	thresholds['rails_best_practices_min'] = 30
	  	thresholds['rails_best_practices_max'] = 100
	  	
	  	thresholds['flog_complexity_min'] = 3
			thresholds['flog_complexity_max'] = 25

	  	thresholds['stats_ratio_min'] = 0.0
	  	thresholds['stats_ratio_max'] = 5.0

			extend Qmeter
			# Call methods from lib/qmeter.rb
			self.initialize_thresholds(thresholds)
			self.generate_final_report
			self.choose_color

			# move report.html from root to the /public folder
			FileUtils.cp('report.html', 'public/') if File.file?("#{Rails.root}/report.html")

    	render layout: false
    end

  end
end