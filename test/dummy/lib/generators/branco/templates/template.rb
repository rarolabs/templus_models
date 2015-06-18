<%%unless params[:render] == 'modal'%>
       <%% content_for :breadcumb do %>
               <li class=""><%%= link_to "<%=@model.name.pluralize.humanize%>", "/crud/<%=@model.name.underscore%>" %></li>
       <%% end %>


       <%% content_for :header do %>
               <%=@action.humanize%>
       <%% end %>

       <%% content_for :scopes do %>
       <%% end %>

       <%% content_for :actions do %>
       <%% end %>

       <%% content_for :modal do %>
       <%% end %>

<%%end%>

<%%= render "layouts/template" %>