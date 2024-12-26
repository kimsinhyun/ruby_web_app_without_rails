# frozen_string_literal: true

require_relative '../router'

Router.draw do
  get('/') do |env|
    puts "#{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}"
    '<h2>Hello, World!</h2>'
  end

  get('/welcome') { '<h1>Welcome to Weby</h1>' }
  get('/goodbye') { '<h1>Goodbye from Weby</h1>' }

  get '/articles/index'
end
