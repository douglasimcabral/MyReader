require 'digest/md5'

class Feed < ActiveRecord::Base

  has_many :entries, dependent: :destroy

  validates_uniqueness_of :url, :case_sensitive => false, :message => "ja foi cadastrada."

  validates_presence_of :title, :message => "obrigatorio."
  
  validates_presence_of :url, :message => "obrigatoria."

  def secret
		Digest::MD5.hexdigest(created_at.to_s)
  end

  def notified params
    update_attributes(:status => params["status"]["http"])

  	params['items'].each do |i|
  		entries.create(:atom_id => i["id"], :title => i["title"], :url => i["permalinkUrl"], :content => i["content"])
  	end
  end

end