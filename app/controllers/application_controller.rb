class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  @date = Date.today
# Define the Game object
  class Game
  	def initialize(homeTeam, awayTeam)
  		@homeTeam = homeTeam
  		@awayTeam = awayTeam
  	end
  	attr_reader :homeTeam
  	attr_reader :awayTeam
  end

  # Pull the site
  def scrape_scoreboard
  	require 'open-uri'
  	doc = Nokogiri::HTML(open("http://www.nba.com/gameline/20151023/"))

  	games = doc.css(".nbaModTopInfo")
  	@gamesArray = []
  	games.each do |g|
  		homeTeam = g.css("h5.hometeam").text
  		awayTeam = g.css("h5.awayteam").text
  		gamesArray = Game.new(homeTeam, awayTeam)
  	end

  	render template: 'scrape_scoreboard'
  end
end