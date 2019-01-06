class PostsController < Sinatra::Base

  $posts = [{
    id: 0,
    title: "Aquaman",
    body: "A fast-paced free-for-all with fantastic special effects and a solid story about a troubled young man who finds himself the last hope for two worlds."
 },
 {
     id: 1,
     title: "Bumblebee",
     body: "Bumblebee does hold up as a fun, family-appropriate movie on its own terms, and redeems its beleaguered franchise in the process."
 },
 {
     id: 2,
     title: "Spider-Man: Into the Spider-Verse",
     body: "Sony is asking us to take another leap off yet another Spider-man origin story, this time with Miles Morales. Lucky for Spider-man fans, with a fresh narrative, relationship building, and innovative visual effects, it's definitely a leap worth taking."
 }]

  # Sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), "..")

  # Sets the view directory
  set :views, Proc.new { File.join(root, "views")}

  # configure :development do
  #   register Sinatra::Reloader
  # end

  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    username == 'shah' and password == 'restricted'
  end

  get '/' do

    @title = "Movie Review Homepage"

    @posts = $posts

    erb :"posts/index"
  
  end
  
  get '/new'  do

    @post = {
      id: "",
      title: "",
      body: ""
    }
  
    erb :"posts/new"
  
  end
  
  get '/:id' do
  
    id = params[:id].to_i
  
    @post = $posts[id]

    erb :"posts/show"
  
  end
  
  post '/' do
  
    new_post = {
      id: $posts.length,
      title: params[:title],
      body: params[:body]
    }

    $posts.push new_post

    redirect "/"
  
  end
  
  put '/:id'  do
  
    id = params[:id].to_i
    post = $posts[id]

    post[:title] = params[:title]
    post[:body] = params[:body]

    $posts[id] = post

    redirect "/"
  
  end
  
  delete '/:id'  do
  
    id = params[:id].to_i

    $posts.delete_at(id)

    redirect "/"
  
  end
  
  get '/:id/edit'  do
  
    id = params[:id].to_i

    @post = $posts[id]

    erb :"posts/edit"
  
  end

end