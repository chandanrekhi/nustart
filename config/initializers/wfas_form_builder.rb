module ActionView::Base::CompiledTemplates
  class WfasFormBuilder < LabelFormBuilder
    def default_template(object)
      %{
        <div class="span-4" style="font-weight: bold;">#{object.label}</div>
        <div class="formElement">#{object}</div>
      }
    end
     
    def template_for_advanced_editor(object)
      %{
          <div class="span-4" style="font-weight: bold;">#{object.label}</div>
          <div class="formElement">#{@template.ajax_error_message_on(@object, object.method)}</div>
          <div class="advancedEditor">#{object}</div>
      }
    end
     
    def advanced_editor(field, *args)
      options = args.extract_options!
      options = options.merge(:ajax => false, :template => :template_for_advanced_editor)

      '<br />' +
        text_area(field, options) +
        @template.advanced_editor_on(@object, field)
    end

    def tags_field(field, *args)
      text_field(field, *args)
    end
  end
end