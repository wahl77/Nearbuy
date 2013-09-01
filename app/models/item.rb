class Item < ActiveRecord::Base
  belongs_to :user

  belongs_to :address
  accepts_nested_attributes_for :address, allow_destroy: true, reject_if: lambda{|address| address[:number_and_street].blank? }

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: lambda{|x| x[:url].blank?}

  has_many :categorizations
  has_many :categories, through: :categorizations

  has_many :comments, as: :commentable, dependent: :destroy

  validates :name,
    presence: true

  validates :address_id,
    presence: true

  validates :categories,
    length:{ minimum: 1, message: "item needs at least one category"}


  def name=(value)
    write_attribute :name, value.capitalize
  end


  #searchable do
  #  text :name, boost: 10
  #  text :description, boost: 7
  #  integer :address_id
  #  integer :category_ids, multiple: true do
  #    categories.map { |x| x.id }
  #  end

  #end

  def self.item_search(query, address=nil, range=10, categories=nil)
    categories ||= Category.pluck(:id)
    #self.search do
    #  fulltext query
    #  with(:address_id, Address.near(address, range).map{|x| x.id})
    #  with(:category_ids, categories)
    #end
    Item.joins(:categories).where("categories.id" => categories, address_id: Address.near(address, range).map{|x| x.id}.to_a).group("items.id").where("items.name @@ :q OR items.description @@ :q", q: "%#{query}%").order("items.id DESC")
  end

  # Find items in a certain radius of a location
  def self.near(address=nil, range=RANGE_CONSTANT, categories=nil)
    categories ||= Category.pluck(:id)
    Item.joins(:categories).where("categories.id" => categories, address_id: Address.near(address, range).map{|x| x.id}.to_a).group("items.id").order("items.id DESC")
  end

end
