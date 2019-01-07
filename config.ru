require 'sinatra'

require 'sinatra/activerecord'

require_relative "./controllers/posts_controller.rb"

use Rack::MethodOverride

run PostsController

