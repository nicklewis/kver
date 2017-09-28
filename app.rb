require 'json'
require 'sinatra'
require 'pp'

set :kvs, {}

get '/kv/:key' do
  if settings.kvs.include?(params[:key])
    [200, settings.kvs[params[:key]].to_json]
  else
    [404, "Key not found"]
  end
end

post '/kv' do
  vals = JSON.parse(request.body.read)
  vals.each do |k,v|
    settings.kvs[k] = v
  end
  204
end

put '/kv/:key' do
  value = JSON.parse(request.body.read)
  settings.kvs[params[:key]] = value
  puts Thread.current
  204
end
