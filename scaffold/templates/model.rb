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
  <%= association.keys.first %> :<%= association.values.first %><%= if throughs.keys.include?(association.values.first) then ", :through => :#{throughs[association.values.first]}" end %><%= ", :dependent => :destroy" if dependencies.include?(association.values.first) %><%= ", :polymorphic => true" if polymorphics.include?(association.values.first) %>
<%- end -%>

  
<%- paperclips.each do |paperclip| -%>
  has_attached_file :<%= paperclip %>
<%- end -%>
  
  # ==============
  # = Attributes =
  # ==============
  <%- if !currencies.blank? -%>
  attr_accessor <%= currencies.map{|item| ":your_#{item}"}.join(', ') %>
  <%- end -%>
  
  # ===============
  # = Validations =
  # ===============
  <%- if !currencies.blank? -%>
  <%- for email in emails -%>
  validates_format_of :<%= email %>, :with => Validator.email_regex, :allow_blank => true
  <%- end -%>
  <%- for currency in currencies -%>
  validates_format_of :your_<%= currency %>, :with => Validator.currency_regex, :allow_blank => true
  <%- end -%>
  <%- end -%>
  <%- paperclip_images.each do |paperclip_image| -%>
  validates_attachment_content_type :<%= paperclip_image %>, 
                                    :content_type => IMAGE_TYPES, 
                                    :message => "is not one of the allowed file types (#{IMAGE_EXTENSIONS.join(", ")}).",
                                    :allow_nil => true
  <%- end -%>
  
  <%- if !currencies.blank? -%>
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