class <%= class_name %> < ActiveRecord::Base
  
  # ================
  # = Associations =
  # ================
<%- associations.each do |association| -%>
  <%= association.keys.first %> <%= association.values.first %>
<%- end -%>
  
<%- paperclips.each do |paperclip| -%>
  has_attached_file :<%= paperclip %>
<%- end -%>
  
<% if !currencies.blank? %>
  # ==============
  # = Attributes =
  # ==============
  attr_accessor <%= currencies.map{|item| ":your_#{item}"}.join(', ') %>
  
  # ===============
  # = Validations =
  # ===============
  <% for currency in currencies %>
  validates_format_of :your_<%= currency %>, :with => Validator.currency_regex, :allow_blank => true
  <% end %>
  
  # =========
  # = Hooks =
  # =========
  before_save <%= currencies.map{|item| ":set_#{item}"}.join(', ') %>
  
  <%- currencies.each do |currency| %>
  def set_<%= currency %>
    self.<%= currency %> = your_<%= currency %>.gsub(/\$|,/, '') if your_<%= currency %>
  end
  <%- end -%>
<% end %>
  
end
