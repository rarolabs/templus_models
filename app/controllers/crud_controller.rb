class CrudController < ApplicationController
  before_filter :setup

  def index
    authorize! :read, @model if respond_to?(:current_usuario)
    if params[:scope].present?
      @q = @model.send(params[:scope]).search(params[:q])
    else
      @q = @model.search(params[:q])
    end
    if @q.sorts.empty?
      if "#{@crud_helper.order_field}".include?("desc") or "#{@crud_helper.order_field}".include?("asc")
        @q.sorts = "#{@crud_helper.order_field}"
      else
        @q.sorts = "#{@crud_helper.order_field} asc"
      end
    end
    if respond_to?(:current_usuario)
      @records = @q.result(distinct: true).accessible_by(current_ability, :read).page(params[:page]).per(@crud_helper.per_page)
    else
      @records = @q.result(distinct: true).page(params[:page]).per(@crud_helper.per_page)
    end
    @titulo = @model.name.pluralize
    render partial: 'records' if request.respond_to?(:wiselinks_partial?) && request.wiselinks_partial?
  end

  def setup
    @model = Module.const_get(params[:model].camelize)
    @crud_helper = Module.const_get("#{params[:model]}_crud".camelize)
  end
  
  def new
    authorize! :create, @model if respond_to?(:current_usuario)
    @record = @model.new
  end
  
  def edit
    authorize! :edit, @model if respond_to?(:current_usuario)
    @record = @model.find(params[:id])
  end

  def show
    authorize! :read, @model if respond_to?(:current_usuario)
    @record = @model.find(params[:id])
  end

  def action
    authorize! :create_or_update, @model if respond_to?(:current_usuario)
    @record = @model.find(params[:id])
    if @model.method_defined?(params[:acao])
      if @record.send(params[:acao])
        flash.now[:success] = "Ação #{params[:acao]} efetuada com sucesso."
      else
        flash.now[:error] = "Erro ao tentar executar a ação #{params[:acao]}."
      end
      index
    else
      @titulo = @record.to_s
      @texto = params[:acao]
      render partial: "/#{@model.name.underscore.pluralize}/#{params[:acao]}"
    end
  end
  
  def create
    authorize! :create, @model if respond_to?(:current_usuario)
    @saved = false
    if params[:id]
      @record = @model.find(params[:id])
      @saved = @record.update(params_permitt)
    else
      @record  =  @model.new(params_permitt)
      @saved = @record.save
    end
    
    respond_to do |format|
      if @saved
        flash[:success] = params[:id].present? ? "Cadastro alterado com sucesso." : "Cadastro efetuado com sucesso."
        format.html { redirect_to "/crud/#{@model.name.underscore}" }
        unless params[:render] == 'modal'
          format.js { render action: :index }
        else
          format.js
        end
      else
        action = (params[:id]) ? :edit : :new
        format.html { render action: action }
        format.js
      end
    end
  end
  
  def destroy
    authorize! :destroy, @model if respond_to?(:current_usuario)
    @record = @model.find(params[:id])
    if @record.destroy
      respond_to do |format|
        flash[:success] = "Cadastro removido com sucesso."
        format.html { redirect_to "/crud/#{@model.name.underscore}" }
        format.js { render action: :index }
      end
    else
      respond_to do |format|
        flash[:error] = @record.errors.full_messages.join(", ")
        format.html { redirect_to "/crud/#{@model.name.underscore}" }
        format.js { render action: :index }
      end
    end
  end
  
  def query
    authorize! :read, @model if respond_to?(:current_usuario)
    @resource = Module.const_get(params[:model].classify)
    @q = @resource.search(params[:q])
    @q.sorts = 'updated_at desc' if @q.sorts.empty?
    if respond_to?(:current_usuario)
      results = @q.result(distinct: true).accessible_by(current_ability).page(params[:page])
    else
      results = @q.result(distinct: true).page(params[:page])
    end
    instance_variable_set("@#{params[:var]}", results)
    if request.respond_to?(:wiselinks_partial?) && request.wiselinks_partial?
      render :partial => params[:partial]
    else
      render :index, controller: request[:controller]
    end
  end

  private
  def params_permitt 
    params.require(@model.name.underscore.to_sym).permit(fields_model)
  end
  
  def fields_model
    fields = []
    @crud_helper.form_fields.each do |field|
      if @model.reflect_on_association(field[:attribute])
        if @model.reflect_on_association(field[:attribute]).macro == :belongs_to
          fields << "#{field[:attribute]}_id".to_sym
        else
          fields << {"#{field[:attribute].to_s.singularize}_ids".to_sym => []}
        end
      elsif (@model.columns_hash[field[:attribute].to_s] || (@model.respond_to?(:params_permitt) && @model.params_permitt.include?(field[:attribute].to_sym)))
        fields << field[:attribute]
      end
    end
  	@crud_helper.form_groups.each do |key, groups|
      chave = "#{key}_attributes"
      group = {chave => [:id, :_destroy]}
      groups.each do |field|
        modelo = key.to_s.camelcase.constantize
        if modelo.reflect_on_association(field[:attribute])
          if modelo.reflect_on_association(field[:attribute]).macro == :belongs_to
            group[chave] << "#{field[:attribute]}_id".to_sym
          else
            group[chave] << {"#{field[:attribute].to_s.singularize}_ids".to_sym => []}
          end
        elsif (modelo.columns_hash[field[:attribute].to_s] || (modelo.respond_to?(:params_permitt) && modelo.params_permitt.include?(field[:attribute].to_sym)))
          group[chave] << field[:attribute]
        end
      end
      fields << group
    end
    fields
  end
end