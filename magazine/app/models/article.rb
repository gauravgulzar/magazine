class Article < ApplicationRecord
	# Tagging and Sub tagging handled by a single table inheritance
	# tagging kept polymorphic so that it can be used to tag other objects if required
	has_many :taggings, -> { where(category: '1') },
				as: :taggable
	has_many :tags, -> { distinct }, through: :taggings
	has_many :sub_taggings, -> { where(category: '0') },
				as: :taggable, class_name: 'Tagging'
	has_many :sub_tags, -> { distinct }, through: :sub_taggings, class_name: 'Tag',
				source: :tag


	belongs_to :user

	default_scope -> { order(created_at: :desc) }

	validates :description, presence: true
	validates :title, presence: true, length: { minimum: 5 }

	attr_accessor :tag_list, :sub_tag_list

	# Gives the name of owner of the article
	def owner_name
		user.name
	end

	# search method which will search in taggings/sub taggings/ title/ content of articles
	def self.search keyword
		# below statement results in single query to search at all possible places
		(keyword_in_title_or_text(keyword) + keyword_in_tags_or_sub_tags(keyword)).uniq
	end

	# this method returns tag list of article
	def tag_list
	 	tags.map(&:name).join(", ")
	end

  	# this method assigns tags to articles
  	def tag_list=(names)
    	self.tags = names.split(",").map do |n|
      		Tag.where(name: n.strip).first_or_create!
    	end
  	end

  	# this method returns sub tag list of article
  	def sub_tag_list
  		sub_tags.map(&:name).join(", ")
  	end

  	# this method assigns sub tags to articles
  	def sub_tag_list=(names)
    	self.sub_tags = names.split(",").map do |n|
      		Tag.where(name: n.strip).first_or_create!
    	end
  	end

  	private

  	# queries for keyword in article title or description
  	# forcing eager load since we're looping over all the articles in view
  	# this prevents N+1 query problem
  	def self.keyword_in_title_or_text keyword
  		Article.eager_load([:tags, :sub_tags, :taggings]).where(
  			"title ILIKE ? OR description ILIKE ?","%#{keyword}%", "%#{keyword}%"
  		)
  	end

	# queries for keyword in tags or sub_tags (both from single table only)
	# forcing eager load since we're looping over all the articles in view
  	# this prevents N+1 query problem
  	def self.keyword_in_tags_or_sub_tags keyword
  		Article.eager_load([:tags, :sub_tags, :taggings]).where(
			"tags.name ILIKE ?", "%#{keyword}%"
			).references(:tags)
  	end
end
