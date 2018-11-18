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
  from r2.lib.template_helpers import static
%>

<%namespace name="utils" file="utils.m"/>
<%namespace file="utils.m" import="error_field"/>

<%inherit file="interstitial.m"/>

<%def name="interstitial_image_attrs()">
  src="${static('interstitial-image-admin.png')}"
  title="${_('Are you one of us?')}"
</%def>

<%def name="interstitial_title()">
  ${_('Enter your password and one-time code')}
</%def>

<%def name="interstitial_message()">
</%def>

<%def name="interstitial_buttons()">
  <form action="/post/adminon" method="post"
      onsubmit="return post_form(this, 'adminon')" id="adminon">
    <div class="spacer">
      <%utils:round_field title="${_('password')}" description="${_('(required)')}" css_class="adminpasswordform">
      % if thing.dest:
          <input type="hidden" name="dest" value="${thing.dest}" />
      % endif
      <input type="password" name="password" tabindex="1" autofocus />
      ${error_field("WRONG_PASSWORD", "password")}
      </%utils:round_field>

      % if not g.disable_require_admin_otp or c.user.otp_secret:
      <%utils:round_field title="${_('one-time verification code')}" description="${_('(required)')}" css_class="adminpasswordform">
      <input type="text" name="otp" maxlength="6" tabindex="1" required pattern="[0-9]{6}" autocomplete="off"
      % if c.otp_cached:
      disabled
      % endif
      />
      ${error_field("WRONG_PASSWORD", "otp")}
      ${error_field("NO_OTP_SECRET", "otp")}
      ${error_field("RATELIMIT", "otp")}

      <label>
          <input type="checkbox" name="remember" tabindex="1"
          % if c.otp_cached:
            disabled
            checked
          % endif
          > ${_("remember this computer")}</label>
      </%utils:round_field>
      % endif

      <div class="buttons">
        <button class="c-btn c-btn-primary" type="submit">
          ${_('turn admin on')}
        </button>
      </div>

      <p class="status error"></p>

    </div>
  </form>
</%def>
