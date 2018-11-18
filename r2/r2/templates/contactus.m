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

  <h1>how can we help you?</h1>
  <p class="info">
    reddit is a community, and as such there are a lot of outlets to get help for what ails you.
  </p>

  <ol class="contact-options">
    <li id="get-help-moderating">
      <h2 class="button">get help moderating</h2>
      <ul class="details">
        <li>Are you a new moderator?  Need advice?  You'll find a community ready to assist you at&#32;<a href="/${g.brander_community_abbr}/modhelp">/${g.brander_community_abbr}/modhelp</a>.</li>
      </ul>
    </li>
    <li id="report-a-bug">
      <h2 class="button">report a bug</h2>
      <ul class="details">
        <li>Check out&#32;<a href="/${g.brander_community_abbr}/bugs">/${g.brander_community_abbr}/bugs</a>&#32;for other people with the same problem, or submit your own bug report.</li>
        <li>If you have an idea for a new feature, tell us about it in&#32;<a href="/${g.brander_community_abbr}/ideasfortheadmins">/${g.brander_community_abbr}/ideasfortheadmins</a>.</li>
      </ul>
    </li>
    <li id="reddit-trademark">
      <h2 class="button">use the reddit trademark</h2>
      <ul class="details">
        <li>You'll need a license to use the reddit trademark.  Read our&#32;<a href="https://www.reddit.com/wiki/licensing">licensing page</a>&#32;to find out how to get permission.</li>
      </ul>
    </li>
    <li id="press-enquiry">
      <h2 class="button">make a press enquiry</h2>
      <ul class="details">
        <li>You can email us at&#32;<a href="mailto:press@reddit.com">press@reddit.com</a>&#32;or call us at&#32;<a href="tel:+1-424-234-9948">+1 424-234-9948</a>.</li>
      </ul>
    </li>
    <li id="advertise">
      <h2 class="button">advertise on reddit</h2>
      <ul class="details">
        <li>Subscribe to&#32;<a href="/${g.brander_community_abbr}/selfserve">/${g.brander_community_abbr}/selfserve</a>&#32;to talk with other advertisers about advertising on reddit.</li>
        <li>Check out&#32;<a href="/${g.brander_community_abbr}/ads">/${g.brander_community_abbr}/ads</a>&#32;to see the most popular image ads on reddit.</li>
        <li>Reach the reddit advertising team at&#32;<a href="mailto:advertising@reddit.com">advertising@reddit.com</a>.</li>
        <li>Learn more about advertising products and best practices at&#32;<a href="/advertising">reddit.com/advertising</a>.</li>
      </ul>
    </li>
    <li id="ask-a-question">
      <h2 class="button">ask a general question</h2>
      <ul class="details">
        <li>Maybe you want to&#32;<a href="/${g.brander_community_abbr}/askreddit">/${g.brander_community_abbr}/askreddit</a>?  Or for help try making a post at&#32;<a href="/${g.brander_community_abbr}/help">/${g.brander_community_abbr}/help</a>.</li>
        <li>Need help with a&#32;<a href="https://redditgifts.com/exchanges">redditgifts exchange</a>? Email&#32;<a href="mailto:support@redditgifts.com">support@redditgifts.com</a>.</li>
        <li>Got a question about&#32;<a href="/gold/about">reddit gold</a>? Please email&#32;<a href="mailto:${g.goldsupport_email}">${g.goldsupport_email}</a>.</li>
        <li>Anything we didn't cover? Email us at&#32;<a href="mailto:contact@reddit.com">contact@reddit.com</a>&#32;and include your reddit username if you have one.</li>
      </ul>
    </li>
    <li id="message-the-admins">
      <h2 class="button">message the admins</h2>
      <ul class="details">
        <li>Need to contact the admins? You can message them&#32;<a href="/message/compose?to=%2Fr%2Freddit.com">here</a>.</li>
        <li>Need to file a&#32;<a href="/help/useragreement#section_dmca">DMCA</a>&#32;takedown request? Please email&#32;<a href="mailto:dmca@reddit.com">dmca@reddit.com</a>&#32;with a link to the content on reddit and all pertinent information.</li>
      </ul>
    </li>
  </ol>

  <img class="space-snoo" title="${_("\"In 5-billion years the Sun will expand and engulf our orbit as the charred ember that was once Earth vaporizes. Have a nice day.\"")}" alt="" src="${static('space-snoo.png')}">

<script type="text/javascript">

$('.contact-options').on('click', 'h2', function() {
  var toggled_details = $(this).siblings(".details");
  if (toggled_details.is(":visible")){
    toggled_details.slideUp();
  } else {
    $(".details").slideUp();
    toggled_details.slideDown();
  }
});
</script>
