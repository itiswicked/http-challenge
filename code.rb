<<-DOC

HTTP Challenge
--------------

* Define the common HTTP verbs
  - These actions are sent by the client, telling the server that the client is requesting:
  - GET:
    - that a resource be sent.
  - POST:
    - for a resource to be created.
  - PUT/PATCH:
    - for a resource to be updated.
  - DELETE:
    - for a resource to be deleted.

* Use the tool of your choice to draw the HTTP request/response cycle.
  - include a link to your diagram, here
  - https://www.dropbox.com/s/y9k1v5fqzjntj6d/http_request_response_cycle.pdf?dl=0
  - Notes are actually uploaded here in http_ruby_notes.md

* Use telnet, curl, or ruby code to retrieve the messages at
  launch-academy-chat.herokuapp.com/messages
  - See below

* Use telnet, curl, or ruby code to create a new message at
  launch-academy-chat.herokuapp.com/messages
  - See below

  - Kernel::system method in ruby will allow you to execute command-line utilities such as curl.
  - other useful ruby libraries:
    * Net::HTTP
    * Net::Telnet

DOC

#########################
### RETRIEVE MESSAGES ###
#########################
require 'pry'
require 'net/http'
require 'nokogiri'

class Posts
  attr_reader :doc
  def initialize(url, resoure)
    @doc = Nokogiri::HTML(Net::HTTP.get(url, resoure))
  end

  def content
    posts.map { |post| "#{post[:time_stamp]}: #{post[:message]}" }
  end

  private

    def posts
      inner_html('pure-u-1-4 created_at').map.with_index do |time_stamp, i|
        {time_stamp: time_stamp, message: inner_html('pure-u-1-2 content')[i]}
      end
    end

    def inner_html(klass)
      doc.xpath("//div[@class='#{klass}']")
         .map { |element| element.inner_html.strip }[1..-1]
    end
end

puts Posts.new('launch-academy-chat.herokuapp.com', '/messages').content

############################
### CREATE A NEW MESSAGE ###
############################
require 'rest-client'

RestClient.post 'http://launch-academy-chat.herokuapp.com/messages',
                {'content' => 'Posting with a ruby script, yo'}
