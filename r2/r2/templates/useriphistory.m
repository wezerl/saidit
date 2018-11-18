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

<%namespace file="prefapps.m" import="authorized_app"/>
<%namespace file="utils.m" import="error_field, timestamp"/>
<%namespace name="utils" file="utils.m"/>

<%
    from r2.lib.strings import strings
    ip_format = {'address': request.ip}
%>

<div id="account-activity" class="instructions">
<h1>${_("Recent activity on your account")}</h1>

<p>${strings.account_activity_blurb}</p>

<p>${strings.your_current_ip_is % ip_format}</p>
<table>
    <thead>
        <tr>
            <th>${_("IP address")}</th>
            <th>${_("Location")}</th>
            <th>${_("Last Visit")}</th>
            <th>${_("Organization")}</th>
        </tr>
    </thead>
    <tbody>
        % for ip_data in thing.ips[:10]:
        <% 
            ip, last_visit, location, org = ip_data[:4]
        %>
        <tr>
            <td>${ip}</td>
            <td>${location.get('country_name', '')}</td>
            <td>${timestamp(last_visit, live=True, include_tense=True)}</td>
            <td>${org}</td>
        </tr>
        % endfor
    </tbody>
</table>
</div>

<hr/>

<h1>${_("Log out of all other sessions")}</h1>

<form action="/post/clear_sessions" method="post"
      onsubmit="return post_form(this, 'clear_sessions')" id="clear_sessions">

<div class="spacer">
  <%utils:round_field title="${_('current password')}" description="${_('(required)')}">
  <input type="password" name="curpass" />
  ${error_field("WRONG_PASSWORD", "curpass")}
  </%utils:round_field>
</div>
<button type="submit" class="btn">${_('clear sessions')}</button>
<span class="status error"></span>

</form>

%if thing.my_apps:
  <hr/>
  <div id="account-activity-apps" class="instructions">
    <h1>${_("Apps you have authorized")}</h1>
    <p>${strings.account_activity_apps_blurb}</p>
    %for app_data in thing.my_apps.values():
      ${authorized_app(app_data)}
    %endfor
  </div>
%endif
