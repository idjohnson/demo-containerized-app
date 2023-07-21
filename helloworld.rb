require 'sinatra'
require 'pg'
    
set :port, 4000
set :bind, '0.0.0.0'

get '/' do
    begin
        # Initialize connection variables.
        host = String('192.168.1.78')
        database = String('demoapp')
        user = String('demoapp')
        password = String('demopass')
    
        # Initialize connection object.
        connection = PG::Connection.new(:host => host, :user => user, :dbname => database, :port => '5432', :password => password)
        puts 'Successfully created connection to database.'
    
        resultSet = connection.exec('SELECT * from demotable;')
        resultSet.each do |row|
            puts 'Data row = (%s, %s)' % [row['id'], row['name']]
        end
    
    rescue PG::Error => e
        puts e.message
    
    ensure
        connection.close if connection
    end
    'Hello World!'
end
