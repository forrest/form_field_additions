module ActionView::Helpers::TagHelper
  alias_method :old_tag, :tag
  alias_method :old_content_tag, :content_tag

  def tag(*args)
    has_tab_label = !!(args[1] and not args[1]["tab_label"].blank?)
    has_prompt = !!(args[1] and not args[1]["prompt"].blank?)

    return old_tag(*args) unless has_prompt or has_tab_label

    html = ""
    id = args[1]["id"]
    if has_tab_label
      html << tab_label_html(id,args[1]["tab_label"])
    end
    html << old_tag(*args)
    html << prompt_script(id,args[1]["prompt"]) if has_prompt
    html << add_tab_label_script(id) if has_tab_label
    html
  end
  
  def content_tag(*args,&block)
    has_tab_label = !!(args[2] and not args[2]["tab_label"].blank?)
    has_prompt = !!(args[2] and not args[2]["prompt"].blank?)
    has_maxlength = !!(args[2] and not args[2]["maxlength"].blank?)

    return old_content_tag(*args,&block) unless ["textarea","select"].include? args[0].to_s
    return old_content_tag(*args,&block) unless has_prompt or has_tab_label or has_maxlength
    
    if has_maxlength
      counter = args[2]["counter"]
      func = counter ? "; enforce_textarea_maxlength(this,$('#{counter}')); " : "; enforce_textarea_maxlength(this); "
      args[2].delete("counter")
      args[2]["onkeyup"] ||= ""
      args[2]["onkeyup"] << func
      args[2]["onchange"] ||= "" #onchange will check the length when you paste changes into the field
      args[2]["onchange"] << func
    end
  
    id = args[2]["id"]
    html = ""
    if has_tab_label
      html << tab_label_html(args,args[2]["tab_label"])
    end
    html << old_content_tag(*args,&block)
    html << prompt_script(id,args[2]["prompt"]) if has_prompt
    html << add_tab_label_script(id) if has_tab_label
    html << javascript_tag("setTimeout(function(){ enforce_textarea_maxlength($('#{id}'),$('#{counter}'));}, 1);") if counter
    html
  end
  
  #==========================================================================================
  private
  
  def tab_label_html(id,label)
    "<div class='tab_label' style='display:none'><span><label for='#{id}'>#{h label}</label></span></div>"
  end
  
  def prompt_script(id,prompt)
    javascript_tag("add_prompt($('#{id}'),'#{escape_javascript prompt}')")
  end
  
  def add_tab_label_script(id)
    javascript_tag("add_tab_label($('#{id}'))")
  end
  
end