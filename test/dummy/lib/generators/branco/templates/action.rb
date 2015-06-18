<%% content_for :corpo do %>
 <div id="form" >
   <%%= render '<%=@action.to_sym%>' %>
 </div>
<%% end %>

<%%= render "template" %>