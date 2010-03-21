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
    <% for currency in currencies %>
      validates_format_of :<%= currency %>, :unless => match_currency_format
    <% end %>
    
    def match_currency_format
      
    end
  <% else %>
    
  <% end %>
  
end
