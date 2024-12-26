# frozen_string_literal: true

require_relative 'application_controller'

class ArticlesController < ApplicationController
  def index
    # '<h2>Articles#index</h2>'
    # index_file = File.join(Dir.pwd, 'views', 'index.html')
    # File.read(index_file)
    @title = "MoriDDang"
    @tagline = "Ruby Web App without Rails"
  end
end
