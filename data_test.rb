require 'linkeddata'
require 'csv'
require 'tmpdir'
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

      

      def self.begin_rebuild
        rebuilder = EOL::Solr::CollectionItemsCoreRebuilder.new
        rebuilder.index_all_collection_items
      end

      def self.reindex_collection(collection)
        rebuilder = EOL::Solr::CollectionItemsCoreRebuilder.new
        rebuilder.index_collection(collection.id)
        # update collection items count
        collection.update_attributes(collection_items_count: collection.collection_items.count)
      end

      def self.reindex_collection_items(collection_items)
        rebuilder = EOL::Solr::CollectionItemsCoreRebuilder.new
        rebuilder.index_collection_items_by_id(collection_items.map(&:id))
      end

      def self.reindex_collection_items_by_ids(collection_item_ids)
        return unless collection_item_ids && collection_item_ids.class == Array
        rebuilder = EOL::Solr::CollectionItemsCoreRebuilder.new
        rebuilder.index_collection_items_by_id(collection_item_ids)
      end

      def self.remove_collection(collection)
        rebuilder = EOL::Solr::CollectionItemsCoreRebuilder.new
        rebuilder.remove_collection_by_id(collection.id)       
      end

      def self.remove_collection_items(items)
        rebuilder = EOL::Solr::CollectionItemsCoreRebuilder.new
        rebuilder.solr_api.delete_by_ids(items.map(&:id))        
      end

      def initialize(options={})
        @solr_api = SolrAPI.new($SOLR_SERVER, $SOLR_COLLECTION_ITEMS_CORE)
        @objects_to_send_to_solr = []
        @debug = options[:debug]
      end

      
          self.objects_to_send_to_solr.last['sort_field'] = SolrAPI.text_filter(sort_field) unless sort_field.blank?
          collection_ids_added[collection_item_id] = true
        end
      end

    end
  end
end
