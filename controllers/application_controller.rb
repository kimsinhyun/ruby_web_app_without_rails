# frozen_string_literal: true

class ApplicationController
  attr_reader :env

  def initialize(env)
    @env = env
  end
end
