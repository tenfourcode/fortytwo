require 'riak'
require 'json'
require 'riak/search' # optional riak_search additions

# Create a client interface
client = Riak::Client.new

# Create a client interface that uses Excon
#client = Riak::Client.new(:http_backend => :Excon)

# Create a client that uses Protocol Buffers
#client = Riak::Client.new(:protocol => "pbc")

# Retrieve a bucket
bucket = client.bucket("fortytwo")  # a Riak::Bucket

# Create a new object
new_one = Riak::RObject.new(bucket, "ruby")
new_one.content_type = "application/json" # You must set the content type.
new_one.data = {'title'=>'Ruby Programming','owner'=>'Daniel', 'tags' => ['user','Daniel','coding']}
new_one.store

puts bucket.get('daniel').inspect

# Create a client, specifying the Solr-compatible endpoint
client = Riak::Client.new :solr => "/solr"
# Search the default index for documents
result = client.search("fortytwo","tags:user") # Returns a vivified JSON object
puts result['response']['numFound'] # total number of results
puts result['response']['start']    # offset into the total result set
puts result['response']['docs']     # the list of indexed documents
