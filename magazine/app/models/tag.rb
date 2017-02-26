class Tag < ApplicationRecord
	has_many :articles, through: :taggings, source: :taggable,
				source_type: "Article"
	has_many :sub_tagged_article, through: :taggings, source: :taggable,
				source_type: "Article_sub_tag", class_name: "Article"
end
