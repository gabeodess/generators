  def index
    @<%= plural_name %> = <%= class_name %>.paginate(:page => params[:page])
  end
