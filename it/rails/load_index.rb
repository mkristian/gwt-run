require 'net/http'
result = Net::HTTP.get(URI.parse('http://localhost:8080'))
puts result
raise 'wrong content' unless result =~ /Demo\/Demo.nocache.js/

result = Net::HTTP.get(URI.parse('http://localhost:8080/Demo/Demo.nocache.js'))
puts result
raise 'wrong content' unless result =~ /Demo.succeeded/
