require 'linkeddata
require 'tmpdir'
 require 'solr'  # load the library
  include Solr    # Allow Solr:: to be omitted from class/module references
 module Solr
    class CollectionItemsCoreRebuilder

attr_accessor :solr_api, :objects_to_send_to_solr, :debug

graph = RDF::Graph.load(File.join(File.dirname(__FILE__), "dataset-1612.rdf"))

query = RDF::Query.new({
  :entry => {
    RDF::URI("http://www.data.gov/semantic/data/alpha/1612/dataset-1612.rdf#pay_grade") => :pay_grade,
    RDF::URI("http://www.data.gov/semantic/data/alpha/1612/dataset-1612.rdf#total_female") => :total_female,
    RDF::URI("http://www.data.gov/semantic/data/alpha/1612/dataset-1612.rdf#total_male") => :total_male
  }
})
  end
end

 def collect_data_from_query(query)
        
query.execute(graph).each do |solution|
             pay_grade=solution.pay_grade
             total_female=solution.total_female
             total_male=solution.total_male
   end
          
          end
 self.objects_to_send_to_solr << {
            'pay_grade'=>pay_grade
            'total_female'=>total_female
            'total_male'=>total_male

          }
# The above code is of intrest to us at this moment to us .


  # connect to the solr instance
  conn = Connection.new('http://localhost:8983/solr', :autocommit => :on)

  # add a document to the index
  conn.add(:pay_grade => pay_grade, :total_female => total_female,:toatal_male=>total_male)

      

      
