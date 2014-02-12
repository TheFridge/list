class StaticPagesController < ApplicationController
  before_action :authenticate, except: [:welcome]


  def welcome
  end
end
