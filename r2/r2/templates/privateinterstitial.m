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

<%inherit file="interstitial.m"/>

<%def name="interstitial_image_attrs()">
  src="${static('interstitial-image-private.png')}"
  alt="${_('private')}"
</%def>

<%def name="interstitial_title()">
  ${_("You must be invited to visit this community")}
</%def>

<%def name="interstitial_message()">
  <p>
    ${_("The moderators of this sub have set it to private. You must be a moderator or approved submitter to visit.")}
  </p>
</%def>

<%def name="interstitial_buttons()">
  <div class="buttons">
    <a class="c-btn c-btn-primary login-required" href="/message/compose/?to=/${g.brander_community_abbr}/${thing.sr_name}">
      ${_("message the moderators")}
    </a>
  </div>
</%def>
