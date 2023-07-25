
require 'sinatra'
require 'pg'
    
set :port, 4000
set :bind, '0.0.0.0'

get '/' do
    begin
        # Initialize connection variables.
        host = String('75.72.238.228')
        database = String('demoapp')
        user = String('demoapp')
        password = String('demopass')
    
        # Initialize connection object.
        connection = PG::Connection.new(:host => host, :user => user, :dbname => database, :port => '5432', :password => password)
        puts 'Successfully created connection to database.'
    
        resultSet = connection.exec('SELECT * from demotable;')
        outStr = "<table><tr><th>id</th><th>name</th></tr>"
        resultSet.each do |row|
            puts 'Data row = (%s, %s)' % [row['id'], row['name']]
            row_data = "<tr><td>#{row['id']}</td><td>#{row['name']}}</td></tr>"
            outStr += "#{row_data}"
        end
        outStr += "</table>"
        outStr
    
    rescue PG::Error => e
        puts e.message
    
    ensure
        connection.close if connection
    end
end

require 'rack'
require 'zipkin-tracer'

ZIPKIN_TRACER_CONFIG = {
  service_name: 'FBSampleApp',
  sample_rate: 1.0,
  json_api_host: ENV["ZIPKIN_URL"]
}.freeze

use ZipkinTracer::RackHandler, ZIPKIN_TRACER_CONFIG
