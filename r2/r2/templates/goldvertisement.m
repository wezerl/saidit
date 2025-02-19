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
  from babel.numbers import format_percent
%>

<div class="goldvertisement">
  <div class="inner">
    <h2
    % if hasattr(thing, "goal_today"):
      title="Goal = $${'%0.2f' % thing.goal_today}"
    % endif
    >${_("daily reddit gold goal")}</h2>

    <div class="progress">
      <p>${format_percent(thing.percent_filled / 100.0, locale=c.locale)}</p>
      <div class="bar">
        <span style="width: ${min(100, thing.percent_filled)}%"></span>
      </div>
    </div>

    <a href="/gold?goldtype=${thing.default_type}&amp;source=progressbar" target="_blank">${_("help support reddit")}</a>

    <div class="gold-bubble hover-bubble help-bubble anchor-top-centered">
      <p><span class="gold-branding">Gold</span>&#32;gives you extra features
      and helps keep our servers running. We believe the more reddit can be
      user-supported, the freer we will be to make reddit the best it can
      be.</p>

      <p class="buy-gold">Buy gold for yourself to gain access to&#32;<a
        href="/gold/about" target="_blank">extra features</a>&#32;and&#32;<a
        href="/${g.brander_community_abbr}/goldbenefits" target="_blank">special benefits</a>. A month of gold pays for
      &#32;<b>${thing.hours_paid}</b>&#32;of Server time!</p>

      <p class="give-gold">Give gold to thank exemplary people and encourage them to post
      more.</p>

      <p class="aside">This daily goal updates every 10 minutes and is reset at
      midnight&#32;<a target="_blank"
        href="https://en.wikipedia.org/wiki/Pacific_Time_Zone">Pacific Time</a>&#32;
      (${thing.time_left_today} from now).</p>

      <div class="history">
        <p
        % if hasattr(thing, "goal_yesterday"):
          title="Goal = $${'%0.2f' % thing.goal_yesterday}"
        % endif
        >${_("Yesterday's reddit gold goal")}</p>

        <div class="progress">
          <p>${format_percent(thing.percent_filled_yesterday / 100.0, locale=c.locale)}</p>
          <div class="bar">
            <span style="width: ${min(100, thing.percent_filled_yesterday)}%"></span>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
