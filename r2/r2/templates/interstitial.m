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
  from r2.lib.filters import unsafe, safemarkdown
%>

<%namespace file="utils.m" import="md"/>

<div class="interstitial">
  <img class="interstitial-image"
       ${self.interstitial_image_attrs()}
       height="150"
       width="150">
  
  <div class="interstitial-message md-container">
    <div class="md">
      <h3>${self.interstitial_title()}</h3>

      %if thing.sr_name and thing.sr_description:
        <div class="interstitial-subreddit-description">
          <h5>${_("%s/%s") % (g.brander_community_abbr, thing.sr_name)}</h5>
          ${md(thing.sr_description)}
        </div>
      %endif

      ${self.interstitial_message()}
    </div>
  </div>
  
  ${self.interstitial_buttons()}
</div>

<%def name="interstitial_image_attrs()">
  src="${static(thing.image)}"
</%def>

<%def name="interstitial_title()">
  ${thing.title}
</%def>

<%def name="interstitial_message()">
  %if thing.message:
    ${md(thing.message)}
  %endif
</%def>

<%def name="interstitial_buttons()">
  <div class="buttons">
    <a href="/" class="c-btn c-btn-primary">${_("back to SaidIt")}</a>
  </div>
</%def>

