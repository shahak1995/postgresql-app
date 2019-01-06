require 'sinatra'

require_relative "./controllers/posts_controller.rb"

use Rack::MethodOverride

run PostsController

