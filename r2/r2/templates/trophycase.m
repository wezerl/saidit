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

<%namespace file="printablebuttons.m" import="ynbutton" />

<%def name="trophy_info(trophy, center)">
  <td class="trophy-info"
      %if center:
        colspan="2"
      %endif
      >
    <div>
      <% trophy_url = trophy.trophy_url %>
      %if trophy_url:
       <a href="${trophy_url}">
      %endif
       <img class="trophy-icon" src="${trophy._thing2.imgurl % 40}" />
       <br/>
       <span class="trophy-name">${trophy._thing2.title}</span>
       <br/>
       %if hasattr(trophy, "description"):
       <span class="trophy-description">${trophy.description}</span>
       <br/>
       %endif
      %if trophy_url:
       </a>
      %endif
      %if c.user_is_admin:
      ${ynbutton(_("remove"), _("removed"), "removetrophy", "hide_thing",
      hidden_data=dict(trophy_fn=trophy._id36))}
      %endif
    </div>
  </td>
</%def>

## for now
%if not thing.trophies:
  <div class="dust">${_("dust")}</div>
%endif

<%def name="trophy_table(trophies, header='')">

  ${unsafe(header)}

  <table class="trophy-table">
    %for i, trophy in enumerate(trophies):
      %if i % 2 == 0:
       <tr>
      %endif

      ${trophy_info(trophy, i == len(trophies) - 1)}

      %if i % 2 == 1:
       </tr>
      %endif
    %endfor

    %if len(trophies) % 2 == 1:
      </tr>
    %endif
  </table>
</%def>

${trophy_table(thing.trophies)}

%if c.user_is_admin and thing.invisible_trophies:
  ${trophy_table(thing.invisible_trophies, "<p>Invisibles:</p>")}
%endif
