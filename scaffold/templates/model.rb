class <%= class_name %> < ActiveRecord::Base
  
  def after_initialize
  <%- currencies.each do |currency| -%>
    self.your_<%= currency %> ||= <%= currency %>.to_s if <%= currency %>
  <%- end -%>
  end
  
  # ================
  # = Associations =
  # ================
<%- associations.each do |association| -%>
  <%= association.keys.first %> :<%= association.values.first %><%= ", :dependent => :destroy" if dependencies.include?(association.values.first) %>
<%- end -%>
  
<%- paperclips.each do |paperclip| -%>
  has_attached_file :<%= paperclip %>
<%- end -%>
  
<%- if !currencies.blank? -%>
  # ==============
  # = Attributes =
  # ==============
  attr_accessor <%= currencies.map{|item| ":your_#{item}"}.join(', ') %>
  
  # ===============
  # = Validations =
  # ===============
  <%- for currency in currencies -%>
  validates_format_of :your_<%= currency %>, :with => Validator.currency_regex, :allow_blank => true
  <%- end -%>
  <%- paperclip_images.each do |paperclip_image| -%>
  validates_attachment_content_type :<%= paperclip_image %>, 
                                    :content_type => IMAGE_TYPES, 
                                    :message => "is not one of the allowed file types (#{IMAGE_TYPES.join(", ")})."
  <%- end -%>
  
  # =========
  # = Hooks =
  # =========
  before_save <%= currencies.map{|item| ":set_#{item}"}.join(', ') %>
  
  <%- currencies.each do |currency| -%>
  def set_<%= currency %>
    self.<%= currency %> = your_<%= currency %>.gsub(/\$|,/, '') if your_<%= currency %>
  end
  
  <%- end -%>
<%- end -%>
  
end