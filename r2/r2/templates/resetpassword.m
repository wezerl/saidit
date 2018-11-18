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

<%namespace file="utils.m" import="error_field"/>
<%namespace name="utils" file="utils.m"/>

%if thing.done:
<p class="error">Your password has been reset and you've been logged in.  Go use the site!</p>
%else:
${error_field("EXPIRED", 'p')}

<form id="chpass" method="post" action="/api/resetpassword" 
      onsubmit="return post_form(this,'resetpassword')">

  <h1>choose a new password for /u/${thing.username}</h1>
  <input type="hidden" name="key" value="${thing.key}"/>

  <div class="spacer">
    <%utils:round_field title="${_('new password')}">
      <input type="password" name="passwd" />
      ${error_field("BAD_PASSWORD", "passwd")}
    </%utils:round_field>
  </div>

  <div class="spacer">
    <%utils:round_field title="${_('verify password')}">
      <input type="password" name="passwd2" />
      ${error_field("BAD_PASSWORD_MATCH", "passwd2")}
    </%utils:round_field>
  </div>

<button class="btn" type="submit">submit</button>
<span class="status"></span>

</form>
%endif
