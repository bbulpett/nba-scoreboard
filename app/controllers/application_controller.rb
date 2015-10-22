class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

# Define the Game object
  class Game
  	def initialize(title, link)
  		@title = title
  		@link = link
  	end
  	attr_reader :title
  	attr_reader :link
  end

  # Pull the site
  def scrape_scoreboard
  	require 'open-uri'
  	doc = Nokogiri::HTML(open("http://sports.espn.go.com/nba/bottomline/scores"))

  	# Parse for headlines and create array
  	@games = doc
  	# @gamesArray = []
  	# headlines.each do |h|
  	# 	title = h.css('h2.titlebox>a').text
  	# 	link = h.css('h2.titlebox>a')[0]['href']
  	# 	@gamesArray << Game.new(title, link)
  	# end

  	render template: 'scrape_scoreboard'
  end
end