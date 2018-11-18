## The contents of this file are subject to the Common Public Attribution
## License Version 1.0. (the "License"); you may not use this file except in
## compliance with the License. You may obtain a copy of the License at
## http://code.reddit.com/LICENSE. The License is based on the Mozilla Public
## License Version 1.1, but Sections 14 and 15 have been added to cover use of
## software over a computer network and provide for limited attribution for the
## Original Developer. In addition, Exhibit A has been modified to be
## consistent with Exhibit B.
##
## Software distributed under the License is distributed on an "AS IS" basis,
## WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
## the specific language governing rights and limitations under the License.
##
## The Original Code is reddit.
##
## The Original Developer is the Initial Developer.  The Initial Developer of
## the Original Code is reddit Inc.
##
## All portions of the code written by reddit are Copyright (c) 2006-2015
## reddit Inc. All Rights Reserved.
###############################################################################

<%!
  from r2.lib.template_helpers import display_link_karma
%>
<%namespace file="printablebuttons.m" import="ynbutton" />
<%namespace file="utils.m" import="plain_link, timestamp"/>

<tr class="${thing.author_cls}">
  %for cell_type in thing.cells:
    <td>
      ${usertablecell(cell_type)}
    </td>
  %endfor
</tr>

<%def name="usertablecell(cell_type)">
  %if cell_type == "user":
      <span class="user">
         ${plain_link(thing.user.name, "/user/%s/" % thing.user.name,
                      _sr_path=False)}
         &nbsp;(<b>${display_link_karma(thing.user.link_karma)}</b>)
      </span>
      &nbsp;
  %elif c.user_is_loggedin and cell_type == "sendmessage" and c.user != thing.user:

      <a href="${'/message/compose/?to=%s' % thing.user.name}" class="access-required"
         data-type="account"
         data-fullname="${thing.user._fullname}"
         data-event-action="compose">
         ${_("send message")}
      </a>
      &nbsp;
  %elif cell_type == "remove":
    %if thing.editable:
      <%
        access_required = getattr(thing, 'remove_access_required', True)
      %>
      ${ynbutton(_("remove"), "removed", thing.remove_action,
                 callback="deleteRow",
                 hidden_data = dict(type = thing.type,
                                    id = thing.user._fullname,
                                    container = thing.container_name),
                 access_required=access_required)}
    %else:
      %if c.user != thing.user:
        <span class="gray">${_("can't remove")}</span>
      %endif
    %endif
  %elif cell_type == "note":
    <form action="/post/${thing.type}note" id="${thing.type}note-${thing.rel._fullname}"
          method="post" class="pretty-form medium-text rel-note ${thing.type}-note"
          onsubmit="return post_form(this, '${thing.type}note');">
      <input type="hidden" name="name" value="${thing.user.name}" />
      <input type="text" maxlength="300" name="note"
             onchange="$(this).parent().addClass('edited')"
             value="${getattr(thing.rel, 'note', '')}" />
      <button onclick="$(this).parent().removeClass('edited')" type="submit">
        ${_("submit")}
      </button>
    </form>
  %elif cell_type == "age":
      ${timestamp(thing.rel._date, include_tense=True)}
  %elif cell_type == "permissions":
      ${thing.permissions}
  %elif cell_type == "permissionsctl":
    %if thing.editable:
      <span class="permissions-edit">
        (<a class="access-required"
            href="javascript:void(0)"
            data-type="account"
            data-fullname="${thing.user._fullname}"
            data-event-action="editsettings"
            data-event-detail="set_permissions"
            >${_('change')}</a>)
      </span>
    %endif
  %elif cell_type == "temp" and hasattr(thing, "tempban"):
    ${_('%(time)s days left') % dict(time=thing.tempban)}
    ${ynbutton(_('make permanent'), _("made permanent"), "friend",
        hidden_data = dict(type=thing.type,
                           name=thing.user.name,
                           container=thing.container_name))}
  %endif
</%def>
