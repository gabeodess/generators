class Create<%= plural_class_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= plural_name %> do |t|
    <%- for attribute in attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %><%- if currencies.include?(attribute.name) -%>, :default => 0<%- end %>
    <%- end -%>
    <%- unless options[:skip_timestamps] -%>
      t.timestamps
    <%- end -%>
    end
  end
  
  def self.down
    drop_table :<%= plural_name %>
  end
end
