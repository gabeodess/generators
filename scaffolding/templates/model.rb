class <%= class_name %> < ActiveRecord::Base
  
  <%- associations.each do |association| -%>
    <%= association.keys.first %> <%= association.values.first %>
  <%- end -%>
  
end
