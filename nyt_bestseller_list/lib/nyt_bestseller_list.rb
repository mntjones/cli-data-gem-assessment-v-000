require 'open-uri'
require 'pry'
require 'nokogiri'

class Restaurant

	attr_accessor :name, :address, :phone, :blurb

	def self.list_item 
		self.scrape
		
		# doc = Nokogiri::HTML(open("https://sf.eater.com/maps/best-new-restaurants-san-francisco-oakland-berkeley-heatmap"))
		
		# list = doc.css(".c-mapstack__cards")
		# list.css("h2").text
		# "Where to eat right now\n1 Funky Elephant\n2 Cdp\n3 dosa By DOSA\n4Eight Tables by George Chen\n5 The SnugSHN Orpheum Theatre\n6 International Smoke\n7 IPPUDO San Francisco\n8 Villon\n9 Nyum Bai\n10 Kaya Restaurant\n11 Barvale\n12 True Laurel\n13 Son’s AdditionRelated Maps"
		# need to split on \n, add each entry into an array
	end

	def self.scrape
		#scrape Eater SF and return restaurants based on that data
		
		restaurants= []

		restaurants << self.scrape_heatmap
		# 1. Go to https://sf.eater.com/maps/best-new-restaurants-san-francisco-oakland-berkeley-heatmap

		# 2. Extract the properties
		# 	a. name
		# 	b. address
		# 	c. phone number
		# 	d. blurb
		# 	e. link addresses
		# 		i. website
		# 		ii. opentable
		# 		iii. foursquare
		# 		iv. maps

		# 3. instantiate a Restaurant object

		restaurants
	end

	def self.scrape_heatmap
		doc = Nokogiri::HTML(open("https://sf.eater.com/maps/best-new-restaurants-san-francisco-oakland-berkeley-heatmap"))
		
		list = doc.css(".c-mapstack__cards")

    #address[0].children.text = "address"
    #address[1].children.text = "phone \n"
    
    address = list.css(".c-mapstack__address")
    adds = []
    phones = []
    hold_add = []

    address.each do |add|
      if add.children.text != nil
        hold_add << add
      end
    end
	
	  hold_add.each.with_index do |info, i|
	    if info.text != nil
	      adds << info.text
	    end
	  end
		
	# all info separated, but how to match address to ph number when one doesn't have a phone?
	
	
		
  # For restaurant names
    hold_name = []
    hold_blurb = []
		cards = list.css("h2")
		blurb = list.css(".c-entry-content")
		
		cards.each do |sect|
		  if sect.css("h2 .c-mapstack__card-index").text != nil
		    hold_name << sect
		  end
		end
		
		
		names = []
		
		hold_name.each.with_index do |name, index|
		  binding.pry
		  if name.children[2] != nil
		    names << name.children[2].text

		  end
		end
		
		
		# the array "names" holds the restaurant names

    
    hold = []
    
    # For info blurbs
    #blurb = list.css(".c-entry-content")
	  
	  list.each do |sect|
	    if sect.css(".c-mapstack__card-index") == nil
	      hold_blurb << ""
	    else
		    # if sect.css(".c-entry-content ").children != nil
		      
		      
		      hold_blurb << sect.children.text
		    #end
		  end
		end
    
		 
	end

    # blurb[1].children.text - first blurb
    
    #Ahhhhh, need to get rid of promotional blurbs! - do have each item as a blurb!
    
    #binding.pry

	
end

Restaurant.scrape_heatmap