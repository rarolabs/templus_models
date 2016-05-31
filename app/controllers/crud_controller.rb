class CrudController < ApplicationController
  before_filter :setup, except: :autocomplete

  private
  def setup
    if params[:associacao]
      @crud_associacao = Module.const_get("#{params[:model].to_s.singularize}_crud".camelize)
      @model = Module.const_get(params[:model].camelize).find(params[:id]).send(params[:associacao])
      c_helper = Module.const_get(params[:model].camelize).reflect_on_association(params[:associacao]).class_name
      @crud_helper = Module.const_get("#{c_helper}Crud") unless params[:render] == "modal" and params[:action] == "new"
      @url = crud_associacao_models_path(model: params[:model], id: params[:id], associacao: params[:associacao], page: params[:page], q: params[:q])
      @url_str = "/crud/#{params[:model]}/#{params[:id]}/#{params[:associacao]}/"
      @model_permission = c_helper.constantize
      @id = params[:associacao_id] if params[:associacao_id]
    else
      @model = Module.const_get(params[:model].camelize)
      @model_permission = @model
      @crud_helper = Module.const_get("#{params[:model]}_crud".camelize) unless params[:render] == "modal" and params[:action] == "new"
      @url = crud_models_path(model: params[:model], page: params[:page], q: params[:q])
      @url_str = "/crud/#{params[:model]}/"
      @id = params[:id] if params[:id]
    end
  end

  public
  def index
    authorize! :read, @model_permission if respond_to?(:current_usuario)
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
      @records = @q.result.accessible_by(current_ability, :read).page(params[:page]).per(@crud_helper.per_page)
    else
      @records = @q.result.page(params[:page]).per(@crud_helper.per_page)
    end
    @titulo = @model.name.pluralize
    render partial: 'records' if request.respond_to?(:wiselinks_partial?) && request.wiselinks_partial?
  end

  def new
    if params[:render] == "modal"
      if @model.reflect_on_association(params[:attribute].to_s).present?
        @model = @model.reflect_on_association(params[:attribute].to_s).class_name.constantize
      else
        @model = params[:attribute].to_s.camelcase.constantize
      end
      @url = crud_models_path(model: @model.name.underscore)
      @model_permission = @model
      @crud_helper = Module.const_get("#{@model}Crud".camelize)
    end
    authorize! :new, @model_permission if respond_to?(:current_usuario)
    @record = @model.new
  end

  def edit
    @record = @model.find(@id)
    authorize! :edit, @record if respond_to?(:current_usuario)
  end

  def show
    @record = @model.find(@id)
    authorize! :read, @record if respond_to?(:current_usuario)
  end

  def action
    @record = @model.find(@id)
    authorize! :create_or_update, @record if respond_to?(:current_usuario)
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
      render partial: "/#{@model.name.underscore.pluralize}/#{params[:acao]}" if request.respond_to?(:wiselinks_partial?) && request.wiselinks_partial?
    end
  end

  def create
    @saved = false
    if @id
      @record = @model.find(@id)
      authorize! :update, @record if respond_to?(:current_usuario)
      @saved = @record.update(params_permitt)
    else
      @record  =  @model.new(params_permitt)
      authorize! :create, @model_permission if respond_to?(:current_usuario)
      @saved = @record.save
    end

    respond_to do |format|
      if @saved
        flash[:success] = params[:id].present? ? "Cadastro alterado com sucesso." : "Cadastro efetuado com sucesso."
        format.html { redirect_to @url }
        unless params[:render] == 'modal'
          format.js { render action: :index}
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
    @record = @model.find(@id)
    authorize! :destroy, @record if respond_to?(:current_usuario)
    if @record.destroy
      respond_to do |format|
        flash[:success] = "Cadastro removido com sucesso."
        format.html { redirect_to @url }
        format.js { render action: :index }
      end
    else
      respond_to do |format|
        flash[:error] = @record.errors.full_messages.join(", ")
        format.html { redirect_to @url }
        format.js { render action: :index }
      end
    end
  end

  def query
    authorize! :read, @model_permission if respond_to?(:current_usuario)
    @resource = @model
    @q = @resource.search(params[:q])
    @q.sorts = 'updated_at desc' if @q.sorts.empty?
    if respond_to?(:current_usuario)
      results = @q.result.accessible_by(current_ability).page(params[:page])
    else
      results = @q.result.page(params[:page])
    end
    instance_variable_set("@#{params[:var]}", results)
    if request.respond_to?(:wiselinks_partial?) && request.wiselinks_partial?
      render :partial => params[:partial]
    else
      render :index, controller: request[:controller]
    end
  end

  def autocomplete
    @model = Module.const_get(params[:model].camelize)
    authorize! :read, @model if respond_to?(:current_usuario)
    parametros = {}
    parametros["#{params[:campo]}_#{params[:tipo]}"] = params[:term]
    @q = @model.search(parametros)
    @q.sorts = 'updated_at desc' if @q.sorts.empty?
    if respond_to?(:current_usuario)
      results = @q.result.accessible_by(current_ability).page(params[:page])
    else
      results = @q.result.page(params[:page])
    end
    method_label = params[:label]
    render json: results.map {|result| {id: result.id, label: result.send(method_label), value: result.send(method_label)} }
  end

  private
  def params_permitt
    params.require(@model.name.underscore.to_sym).permit(fields_model)
  end

  def fields_model
    fields = []
    @crud_helper.form_fields.each do |field|
      if field[:sf].present? && field[:sf][:grupo].present?
        fields << permitt_group(fields, field[:attribute], field[:sf][:fields],@model)
      else
        if @model.reflect_on_association(field[:attribute])
          if @model.reflect_on_association(field[:attribute]).macro == :belongs_to
            fields << @model.reflect_on_association(field[:attribute]).foreign_key
          else
            fields << {"#{field[:attribute].to_s.singularize}_ids".to_sym => []}
          end
        elsif @model.columns_hash[field[:attribute].to_s]
          fields << field[:attribute]
        end
      end
    end
    #TODO - Deprecated
  	@crud_helper.form_groups.each do |key, groups|
      fields << permitt_group(fields, key, groups[:fields],@model)
    end
    #Fim - Deprecated
    if @model.respond_to?(:params_permitt)
      @model.params_permitt.each do |field|
        fields << field
      end
    end
    fields
  end

  def permitt_group(fields, key, groups,mod)
    chave = "#{key}_attributes"
    group = {chave => [:id, :_destroy]}
    groups.each do |field|
      if field[:sf].present? && field[:sf][:grupo].present?
        group[chave] << permitt_group(fields, field[:attribute], field[:sf][:fields], mod.reflect_on_association(key.to_s).class_name.constantize)
      else
        modelo = mod.reflect_on_association(key.to_s).class_name.constantize
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
    end
    group
  end
end
