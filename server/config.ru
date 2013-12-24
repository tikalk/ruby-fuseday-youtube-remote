require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra'

require './app'

def run(opts)

  $channel = EM::Channel.new

  # Start he reactor
  EM.run do

    # define some defaults for our app
    server  = opts[:server] || 'thin'
    host    = opts[:host]   || '0.0.0.0'
    port    = opts[:port]   || '8181'
    web_app = opts[:app]

    # create a base-mapping that our application will set at. If I
    # have the following routes:
    #
    #   get '/hello' do
    #     'hello!'
    #   end
    #
    #   get '/goodbye' do
    #     'see ya later!'
    #   end
    #
    # Then I will get the following:
    #
    #   mapping: '/'
    #   routes:
    #     /hello
    #     /goodbye
    #
    #   mapping: '/api'
    #   routes:
    #     /api/hello
    #     /api/goodbye
    dispatch = Rack::Builder.app do
      map '/' do
        run web_app
      end
    end

    get '/client' do

      @redis = EM::Hiredis.connect
      puts 'subscribing to redis'
      @redis.pubsub
      @redis.on(:message){|channel, message| 
        puts "redis -> #{channel}: #{message}"
        $channel.push message 
      }

      EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 1234) do |ws|
        puts 'Establishing websocket'
        ws.onopen do
          puts 'client connected'
          puts 'subscribing to channel'
          sid = $channel.subscribe do |msg| 
            puts "sending: #{msg}"
            ws.send msg
          end

          ws.onmessage { |msg|
            $channel.push "<#{sid}>: #{msg}"
          }

          ws.onclose {
            $channel.unsubscribe(sid)
          }
        end
      end
    end

    # NOTE that we have to use an EM-compatible web-server. There
    # might be more, but these are some that are currently available.
    unless ['thin', 'hatetepe', 'goliath'].include? server
      raise "Need an EM webserver, but #{server} isn't"
    end

    # Start the web server. Note that you are free to run other tasks
    # within your EM instance.
    Rack::Server.start({
      app:    dispatch,
      server: server,
      Host:   host,
      Port:   port
    })
  end
end

run app: Sinatra::Application
