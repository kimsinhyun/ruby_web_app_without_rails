# frozen_string_literal: true

require 'erb'

class ApplicationController
  attr_reader :env

  def initialize(env)
    @env = env
  end

  def render(view_template)
    erb_template = ERB.new File.read(view_template)
    erb_template.result binding # 현재 controller 의 환경을 binding 으로 넘겨줌
  end
end
