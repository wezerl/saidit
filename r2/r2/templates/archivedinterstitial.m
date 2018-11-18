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
  from r2.lib.template_helpers import static, _wsf
%>

<%inherit file="interstitial.m"/>

<%def name="interstitial_image_attrs()">
  src="${static('interstitial-image-archived.png')}"
  alt="${_('archived')}"
</%def>

<%def name="interstitial_title()">
  ${_("This is an archived post. You won't be able to vote or comment.")}
</%def>

<%def name="interstitial_message()">
  <%
    months = ungettext('month', 'months', thing.archive_age_months)
  %>
  <p>
    ${_wsf("Posts are automatically archived after %(num)s %(months)s.",
           num=thing.archive_age_months, months=months)}
  </p>
</%def>

<%def name="interstitial_buttons()">
  <div class="buttons">
    <a href="/" class="c-btn c-btn-primary">${_("Got It")}</a>
  </div>
</%def>
