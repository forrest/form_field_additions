module ActionView::Helpers::TagHelper
  alias_method :old_tag, :tag

  def tag(*arg)
    html = ""
    has_tab_label = !!(arg[1] and not arg[1]["tab_label"].blank?)
    has_prompt = !!(arg[1] and not arg[1]["prompt"].blank?)

    if has_tab_label
      html << "<div class='tab_label' style='display:none'><span><label for='#{arg[1]["id"]}'>#{h arg[1]["tab_label"]}</label></span></div>"
    end
    html << old_tag(*arg)
    html << javascript_tag("add_prompt($('#{arg[1]["id"]}'),'#{escape_javascript arg[1]["prompt"]}')") if has_prompt
    html << javascript_tag("add_tab_label($('#{arg[1]["id"]}'),'#{escape_javascript arg[1]["tab_label"]}')") if has_tab_label
    html
  end
end