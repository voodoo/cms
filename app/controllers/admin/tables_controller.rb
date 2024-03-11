class Admin::TablesController < MblzController
  def index
    @tables = ActiveRecord::Base.connection.select("show tables")
  end  
  def show
    @table_name = params[:id]
    pid         = params[:pid]
    where       = pid ? "id = #{pid}" : nil
    @table      = @table_name.singularize.capitalize.constantize.where(where).order('id desc').limit(1)
  end
end