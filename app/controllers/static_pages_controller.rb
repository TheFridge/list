class StaticPagesController < ApplicationController
  before_action :authenticate, expect[:welcome]


  def welcome
  end
end
