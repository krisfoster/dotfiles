;;; arorem-abbrevs.el

;; Part of arorem - Another Ruby on Rails Emacs Mode
;; Uses snippet.el to set up auto-expanded abbreviations
;; Thanks to TextMate, Pete Kazmier, and Galinsky Dmitry

(snippet-with-abbrev-table arorem-abbrev-table
    ;; model
    ("bt" . "belongs_to")
    ("hm" . "has_many")
    ("ho" . "has_one")
    ;; controller renders
    ("ra" . "render :action => \"$${action}\"")
    ("ral" . "render :action => \"$${action}\", :layout => \"$${layoutname}\"")
    ("rf" . "render :file => \"$${filepath}\"")
    ("rfu" . "render :file => \"$${filepath}\", :use_full_path => $${false}")
    ("ri" . "render :inline => \"$${<%= 'hello' %>}\"")
    ("ril" . "render :inline => \"$${<%= 'hello' %>}\", :locals => { $${name} => \"$${value}\" }")
    ("rit" . "render :inline => \"$${<%= 'hello' %>}\", :type => :$${rxml})")
    ("rl" . "render :layout => \"$${layoutname}\"")
    ("rn" . "render :nothing => $${true}")
    ("rns" . "render :nothing => $${true}, :status => $${401}")
    ("rp" . "render :partial => \"$${item}\"")
    ("rpc" . "render :partial => \"$${item}\", :collection => $${items}")
    ("rpl" . "render :partial => \"$${item}\", :locals => { :$${name} => \"$${value}\"}")
    ("rpo" . "render :partial => \"$${item}\", :object => $${object}")
    ("rps" . "render :partial => \"$${item}\", :status => $${500}")
    ("rt" . "render :text => \"$${Text here...}\"")
    ("rtl" . "render :text => \"$${Text here...}\", :layout => \"$${layoutname}\"")
    ("rtlt" . "render :text => \"$${Text here...}\", :layout => $${true}")
    ("rts" . "render :text => \"$${Text here...}\", :status => $${401}")
    ("rcea" . "render_component :action => \"$${index}\"")
    ("rcec" . "render_component :controller => \"$${items}\"")
    ("rceca" . "render_component :controller => \"$${items}\", :action => \"$${index}\"")
    ;; redirects
    ("rea" . "redirect_to :action => \"$${index}\"")
    ("reai" . "redirect_to :action => \"$${show}\", :id => $${@item}")
    ("rec" . "redirect_to :controller => \"$${items}\"")
    ("reca" . "redirect_to :controller => \"$${items}\", :action => \"$${list}\"")
    ("recai" . "redirect_to :controller => \"$${items}\", :action => \"$${show}\", :id => $${@item}")
    ;; assertions
    ("ae" . "assert_equal $${expected}, $${actual}")
    ("ann" . "assert_not_nil $${object}")
    ("ako" . "assert_kind_of $${class}, $${object}")
    ("are" . "assert_response :$${success}")
    ("ar" . "assert_raises $${Exception} { $. }")
    ("art" . "assert_redirected_to :controller => \"$${controller}\"")
    ;; validations
    ("va" . "validates_associated :$${attr}")
    ("vc" . "validates_confirmation_of :$${attr}")
    ("ve" . "validates_exclusion_of :$${attr}")
    ("vp" . "validates_presence_of :$${attr}")
    ("vu" . "validates_uniqueness_of :$${attr}")
    ("vn" . "validates_numericality_of :$${attr}")
    ("vf" . "validates_format_of :$${attr}, :with => /$${regex}/")
    ;; misc
    ("flash" . "flash[:$${notice}] = \"$${Text here...}\"")
    ("logi" . "logger.info \"$${Text here...}\"")
    ("par" . "params[:$${id}]")
    ("ses" . "session[:$${user}]"))

(snippet-with-abbrev-table arorem-rhtml-abbrev-table
    ;; view
    ("ft" . "<%= form_tag :action => \"$${update}\" %>\n$.\n<%= end_form_tag %>")
    ("lia" . "<%= link_to \"$${title}\", :action => \"$${index}\" %>")
    ("liai" . "<%= link_to \"$${title}\", :action => \"$${edit}\", :id => $${@item} %>")
    ("lic" . "<%= link_to \"$${title}\", :controller => \"$${items}\" %>")
    ("lica" . "<%= link_to \"$${title}\", :controller => \"$${items}\", :action => \"$${index}\" %>")
    ("licai" . "<%= link_to \"$${title}\", :controller => \"$${items}\", :action => \"$${edit}\", :id => $${@item} %>")
    ("h" . "<% h $${@item} %>")
    ("if" . "<% if $${cond} -%>\n$.\n<% end -%>")
    ("ifel" . "<% if $${cond} -%>\n$.\n<% else -%>\n<% end -%>")
    ("unless" . "<% unless $${cond} -%>\n$.\n<% end -%>")
    ("%" . "<% $. -%>")
    ("%%" . "<%= $. %>"))