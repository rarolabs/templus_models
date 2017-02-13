module SearchHelper

  def raro_search_form(model,partial,collection_name,url,sort = nil)
      @buffer = raro_before_form(model,partial,collection_name,url,sort)
      @model = model
      yield
      @buffer << raro_submit("Pesquisar")
      @buffer << raro_after_form
      @buffer << raro_script
      @buffer.html_safe
  end

  private

    def raro_submit(name)
      "<div><input type='submit' class='btn btn-primary pull-right' value='#{name}' id='submit_raro_search'></div><br><br>"
    end

    def raro_field (name, opts = {})
      unless opts[:model]
        prototype = @model.columns_hash[name.to_s]
        return "" unless prototype
      else
        prototype =  Module.const_get(opts[:model]).columns_hash[name.to_s]
        name = opts[:full_name]
      end
      label = name
      label = opts[:label] if opts[:label]

      @buffer << "<div class=\"form-group\">"
      @buffer << raro_label(label,opts)
      @buffer << "<div class='col-sm-10'>"
      @buffer << raro_input(name, prototype.type, opts)
      @buffer << "</div>"
      @buffer << "</div>"
    end

    def raro_field_custom(name, type, opts={})
      label = name
      label = opts[:label] if opts[:label]
      @buffer << "<div class=\"control-group\">"
      @buffer << raro_label(label,opts)
      @buffer << "<div class='controls'>"
      @buffer << raro_input(name, type, opts)
      @buffer << "</div>"
      @buffer << "</div>"
    end

    def raro_input(name, type,opts)
      if opts[:as] && type != :datetime && type != :date
        return raro_input_as(name,type,opts)
      end

      case type
        when :integer
          if name =~ /\_id$/ and not opts[:dont_assoc]
            return raro_belongs_to(name,opts)
          else
            return raro_integer_field(name)
          end
        when :float
          return raro_integer_field(name)
        when :decimal
          return raro_integer_field(name)
        when :datetime
          return raro_date_range(name)
        when :date
          return raro_date_range(name)
        when :boolean
          return raro_radio(name, opts)
        when :monthyear
          return raro_monthyear(name, opts)
        else
          return raro_text_field(name, opts)
      end
    end

    def raro_input_as(name,type,opts)
      case opts[:as]
      when :select
        if opts[:collection_if] and opts[:collection_if].class == Proc
          opts[:collection] = ActionView::Helpers::FormBuilder.instance_eval &opts[:collection_if]
        end
        raro_select(name,opts,opts[:collection])
      when :hidden
        return raro_hidden_field(name,opts[:value],opts)
      when :string
        raro_text_field(name, opts)
      when :range
        raro_range(name)
      end
    end

    def raro_belongs_to(name,opts)
      collection = []
      model_name = name.to_s.gsub(/\_id$/,'')
      Module.const_get(model_name.camelcase).all.each do |e|
        val = opts[:collection_member] ? e.send(opts[:collection_member]) : e.to_s
        collection.push([e.id,val])
      end
      return raro_select("q[#{model_name}_id_eq]",opts,collection)
    end

    def raro_select(name,opts,collection)
      unless opts[:model]
        name = "q[#{name}_eq]"
      end
      buf = "<div class='col-sm-12'>"
      if opts[:multiple]
        buf << "<select name=#{name} class='form-control' multiple='multiple' size='8'>"
      else
        buf << "<select name=#{name} class='form-control'>"
      end
      buf <<"<option value ='' selected>Escolha...</option>"
      collection.each do |e|
        buf << "<option value=#{e[0]}>#{e[1]}</option>"
      end
      buf << "</select>"
      buf << "</div>"
      return buf
    end

    def raro_label(name,opts)
      if opts[:as] and opts[:as] == :hidden
        ""
      else
      "<label class='col-sm-2 control-label'>#{name}</label>"
      end
    end

    def raro_text_field(name, opts)
      buffer = ""
      buffer += "<div class='col-sm-4'>"
      buffer += raro_string_operators(name)
      buffer += "</div>"
      buffer += "<div class='col-sm-8'>"
      buffer += "<input id='q_#{name}' type='text' name='q[#{name}_cont]' class='form-control #{opts[:class]}'/>"
      buffer += "</div>"
      buffer
    end

    def raro_monthyear(name, opts)
      buffer = ""
      buffer += "<div class='col-sm-8'>"
      buffer += "<input id='q_#{name}' type='text' name='q[#{name}_cont]' class='form-control #{opts[:class]}'/>"
      buffer += "</div>"
      buffer
    end

    def raro_hidden_field(name,value,opts)
      if opts[:predicate].present?
        "<input id='q_#{name}' type='hidden' name='q[#{name}_#{opts[:predicate]}]' value='#{value}'/>"
      else
        "<input id='q_#{name}' type='hidden' name='q[#{name}_eq]' value='#{value}'/>"
      end
    end

    def raro_integer_field(name)
      buffer = ""
      buffer += "<div class='col-sm-4'>"
      buffer += raro_comparison_operators(name)
      buffer += "</div>"
      buffer += "<div class='col-sm-8'>"
      buffer += "<input id='q_#{name}' type='number' name='q[#{name}_eq]' class='form-control'/>"
      buffer += "</div>"
      buffer
    end

    def raro_radio(name, opts)
      buff = ""
      if opts[:collection].present?
        opts[:collection].each do |opt|
          buff<<"<label>"
          buff<<"<div class='checkbox'>"
          buff<<"<input id='q_#{name}' type='radio' name='q[#{name}_eq]' value='#{opt[0]}' class='i-checks'/>"
          buff<<"</div>"
          buff<<"<span class='lbl'> #{opt[1]}</span>"
          buff<<"</label>"
        end
      else
        buff<<"<div class='col-sm-4'>"
        buff<<"<div class='col-sm-6'>"
        buff<<"<input id='q_#{name}' type='radio' name='q[#{name}_eq]' value='1' class='i-checks'/>"
        buff<<"<span class='lbl'> Sim</span></label>"
        buff<<"</div>"
        buff<<"<div class='col-sm-6'>"
        buff<<"<input id='q_#{name}' type='radio' name='q[#{name}_eq]' value='0' class='i-checks'/>"
        buff<<"<span class='lbl'> Não</span>"
        buff<<"</div>"
        buff<<"</div>"
      end
      buff
    end

    def raro_date_range(name)
      "<div class='col-sm-6'>
      <div class=\"input-group date\">
      <span class=\"input-group-addon\"><i class=\"fa fa-calendar\"></i></span>
      <input class=\"raro_date_range form-control\" type=\"text\"
             name=\"date-range_#{name}\"
             id='q_#{name}_range'
             data-start-target=\"#q_#{name}_start\"
             data-end-target=\"#q_#{name}_end\" >
      <input type='hidden' value='' id='q_#{name}_start' name='q[#{name}_gteq]'>
      <input type='hidden' value='' id='q_#{name}_end' name='q[#{name}_lteq]'>
      </div></div>"
    end

    def raro_range(name)
      buffer = "<div class='col-sm-4'>"
      buffer += "<input type='text' name='q[#{name}_gteq]' class='form-control'/>"
      buffer += "</div>"
      buffer += "<div class='col-sm-4 range-separator'>"
      buffer += "<input type='text' name='q[#{name}_lteq]' class='form-control'/>"
      buffer += "</div>"
      buffer
    end

    def raro_before_form(model,partial,var,url,sort)
      buffer = "<div id='search_box'>"+
      "<form method='get' class=form-horizontal action='#{url}' data-push='partial' data-target='#form'>" +
      "<input type='hidden' name='partial' value='#{partial}'>" +
      "<input type='hidden' name='var' value='#{var}'>"
      if sort
         buffer << "<input type='hidden' name='q[s]' value='#{sort}'>"
       end
       buffer
    end

    def raro_after_form
       "</form></div>"
    end

    def raro_script
      "<script>
      $('#submit_raro_search').click(function (){
        $('#modal_search').modal('hide');
      });
      </script>"
    end

    def raro_comparison_operators(target)
      "<select class='form-control m-b' onchange='window.search_predicate(this)' data-target='#q_#{target}'>
       <option value=eq selected>Igual</option>
       <option value=not_eq>Diferente</option>
       <option value=gt>Maior</option>
       <option value=lt>Menor</option>
       <option value=gteq>Maior ou Igual</option>
       <option value=lteq>Menor ou Igual</option></select>"
    end

    def raro_string_operators(target)
      "<select class='form-control m-b' onchange='window.search_predicate(this)' data-target='#q_#{target}'>
      <option value=cont>Contém</option>
      <option value=eq>Igual</option>
      <option value=not_cont>Não Contém</option>
      <option value=start>Começa</option>
      <option value=end>Termina</option>
      </select>"
    end

    def raro_group(text)
      @buffer << "<div class=\"col-sm-12 label label-primary\" style=\"margin-bottom:10px; font-size:14px;display: inline-block;\"><b>#{text}</b></div>"
    end
end
