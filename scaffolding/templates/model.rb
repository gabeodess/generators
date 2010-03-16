class <%= class_name %> < ActiveRecord::Base
  
  <%- associations.each do |association| -%>
    <%= association.keys.first %> <%= association.values.first %>
  <%- end -%>
  
  <%- paperclips.each do |paperclip| -%>
    has_attached_file :<%= paperclip %>
  <%- end -%>
  
end
