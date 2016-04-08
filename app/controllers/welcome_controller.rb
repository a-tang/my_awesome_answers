class WelcomeController < ApplicationController

  #this defines an 'action' called index for the 'WelcomeController'
  def index
    #render text: "Hello world!"

    #by detfault (convention) Rails will render:
    #views/welcome/index.html.erb (when reiceiveing a request that has an HTML format)

    # if you use another format by going to url such as /hone.text' rails will render a template according to that format so in the case of 'home.text' will be:
    # `/home.text` it will be:
  # views/welcome/index.text.erb

  end

  def about

  end
  
end
