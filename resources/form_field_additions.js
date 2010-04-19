/*Installed by the InputFieldPrompt plugin. Check the readme for more details.

	Author: Forrest Zeisler
	February 27, 2009
*/

var PROMPT_CLASS = "prompt"

function add_prompt(input,value)
{
  input_item = Element.extend(input);
  input_item.writeAttribute("prompt",value);
  input.observe('focus',prompt_onfocus);
  input.observe('blur',prompt_onblur);
  input_item.writeAttribute("promptAdded",true);
  if(input_item.readAttribute("value")==null || input_item.readAttribute("value")=="")
     input_item.writeAttribute("value",value);
  prompt_onblur(input);
}

function prompt_onblur(event_or_input)
{
  if(Object.isElement(event_or_input))
    input = event_or_input;
  else
    input = event_or_input.element();
  value = input.readAttribute("prompt").strip();
  current = $F(input).strip();

  //if it is the default value set to grey
  if(current==value || current.length==0)
      input.addClassName(PROMPT_CLASS);

  //if it is not a select field set the value to the default
  if(input.tagName!="SELECT" && current.length==0)
      input.value = value;
}

function prompt_onfocus(event)
{
  input = event.element();
  value = input.readAttribute("prompt").strip();
  current = $F(input).strip();
  if(current==value)
      input.value = "";
  input.removeClassName(PROMPT_CLASS);
}

function add_tab_label(input)
{
  input_item = Element.extend(input);
  input_item.writeAttribute("prompt",value);
  input.observe('focus',tab_label_onfocus);
  input.observe('blur',tab_label_onblur);
}

function tab_label_onfocus(event)
{
  input = event.element();
  label_div = input.previous("div");
  if(!label_div.hasClassName("tab_label"))
    return;
  label_div.clonePosition(input,{setLeft:true, setTop:true, setWidth:true, setHeight:true});
  label_div.show();
}

function tab_label_onblur(event)
{
  input = event.element();
  label_div = input.previous("div");
  if(!label_div.hasClassName("tab_label"))
    return;
  label_div.hide();
}

function enforce_textarea_maxlength(textarea,count)
{
    textarea = Element.extend(textarea);
    ml = $(textarea).getAttribute('maxlength');    
    if(!ml)
        return;
    v = $F($(textarea));
	
    if(v.gsub(/\n/,"<br/>").length>ml)
    {
      st = $(textarea).scrollTop;
      $(textarea).value = (v.truncate(ml,""));
      $(textarea).scrollTop = st;
    }

    new_v = $F($(textarea));
	if(textarea.readAttribute("prompt") && new_v==textarea.readAttribute("prompt").strip())
		new_v = "";
    if(count)
	{
		left = ml-new_v.length;
		count.update(left);
		if(left==0)
			count.addClassName("full_counter");
		else if(left<=10)
		{
			count.removeClassName("full_counter");
			count.addClassName("last_ten");
		}
		else
		{
			count.removeClassName("full_counter");
			count.removeClassName("last_ten");
		}
	}
    
    return;
}
