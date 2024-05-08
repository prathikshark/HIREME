class PagesController < ApplicationController

  def home
    # @workers_with_high_rating = Worker.joins(:worker_skills).where(worker_skills: { rating: 4..5 }).distinct
  end

  def aboutus
  end

  def contactus
  end

  def portal
  end
  
end
