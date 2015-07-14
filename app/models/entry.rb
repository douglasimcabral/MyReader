class Entry < ActiveRecord::Base
	belongs_to :feed

	validates :atom_id, uniqueness: {scope: :feed_id}

	default_scope {
		order('created_at DESC')
	}
end