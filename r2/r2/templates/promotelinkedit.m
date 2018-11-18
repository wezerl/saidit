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
  from r2.lib import promote
  from r2.lib import js
%>

<%namespace name="pr" file="promotelinkbase.m" />
<%namespace file="utils.m" name="utils" />


${unsafe(js.use('sponsored'))}

<div class="create-promotion sponsored-page">
  <div class="dashboard creative-dashboard">
    <header>
      <h2>${_("creative dashboard")}</h2>
      ${thing.infobar}
    </header>
    <div class="dashboard-content">
      ${self.creative_editor()}
    </div>
  </div>

  <div class="dashboard campaign-dashboard">
    <header>
      <h2>${_("campaign dashboard")}</h2>
      <div class="help" style="${'display:none' if not thing.campaigns else ''}">
        <p></p>
      </div>
      <p class="error"
         style="${'display:none' if thing.campaigns else ''}">
        ${_("You don't have any campaigns for this link yet.  You should add one.")}
      </p>
      <%
        newcamp_title = _("click to create a new campaign.  To edit an existing " 
                          "campaign in the table below, click the 'edit' button.")
      %>
      <button class="new-campaign primary-button"
          ${'disabled="disabled"' if len(thing.campaigns) >= g.MAX_CAMPAIGNS_PER_LINK or not thing.campaigns else ''}
          title="${newcamp_title}"
          name="new-campaign"
          onclick="return create_campaign()">+ new campaign</button>
    </header>
    <div class="dashboard-content">
      <div class="new-campaign-container">
        ${self.campaign_editor()}
      </div>
      ${self.campaign_list()}
    </div>
  </div>

  %if c.user_is_sponsor:
    <div class="dashboard admin-dashboard">
      <header>
        <h2>${_("admin dashboard")}</h2>
      </header>
      <div class="dashboard-content">
        ${pr.admin_panel()}
      </div>
    </div>
  %endif
</div>

${pr.javascript_setup()}


<%def name="campaign_editor()">
  <div class="pretty-form campaign-editor editor" id="campaign"
       style="${'display:none' if thing.campaigns else ''}">
    <div class="campaign" method="post" action="/api/add_campaign">
      <input type="hidden" name="link_id36" value="${thing.link._id36}">
      <div class="editor-group">
        ${pr.targeting_field()}
        ${pr.is_auction_field()}
        ${pr.platform_field()}
        ${pr.frequency_cap_field()}
        ${pr.priority_field()}
        ${pr.budget_field()}
        ${pr.scheduling_field()}
        ${pr.pricing_field()}
        ${pr.is_new_field()}
        <%utils:line_field title="${_('confirm')}" css_class="rounded confirmation-field">
          <div id="campaign-creator">
          </div>
          ${utils.error_field("COST_BASIS_CANNOT_CHANGE", "cost_basis", "div")}
          ${utils.error_field("BAD_BUDGET", "total_budget_dollars", "div")}
          ${utils.error_field("BUDGET_LIVE", "total_budget_dollars", "div")}
        </%utils:line_field>
      </div>
      <footer class="buttons">
        <input type="hidden" name="campaign_id36" value="">
        <input type="hidden" name="campaign_name" value="">
        <input type="hidden" name="id" value="#campaign">
        <span class="status error"></span>
        <button name="cancel"
                onclick="return cancel_edit_campaign()">
          ${_("cancel")}
        </button>
      </footer>
    </div>
  </div>
</%def>

<%def name="campaign_list()">
  <%
    start_title = _("Date when your sponsored link will start running.  We start new campaigns at midnight UTC+5")
    end_title = _("Date when your sponsored link will end (at midnight UTC+5)")
    targeting_title = _("name of the community that you are targeting. A blank entry here means that the ad is untargeted and will run site-wide ")
  %>
  
      <div class="campaign-list">
        <div class="error TOO_MANY_CAMPAIGNS field-title infotext ${'hidden' if len(thing.campaigns) < g.MAX_CAMPAIGNS_PER_LINK else ''}"
             data-MAX="${g.MAX_CAMPAIGNS_PER_LINK}"
             data-CAMP="${len(thing.campaigns)}">
          <p>
            ${_("You have too many campaigns for this link.")}&#32;
            <a href="/promoted/new_promo/">${_("It's time to start fresh!")}</a>
          </p>
        </div>
        <div class="existing-campaigns"
             data-max-campaigns="${g.MAX_CAMPAIGNS_PER_LINK}">
          <table style="${'display:none' if not thing.campaigns else ''}">
            <thead>
              <tr class="campaign-header-row">
                <th class="campaign-start-date" title="${start_title}">${_("start")}</th>
                <th class="campaign-end-date" title="${end_title}">${_("end")}</th>
                <th class="campaign-priority" style="${'display:none' if not c.user_is_sponsor else ''}">
                  ${_("priority")}
                </th>
                <th class="campaign-total-budget">${_("total budget")}</th>
                <th class="campaign-spent">${_("spent")}</th>
                %if thing.ads_auction_enabled:
                  <th class="campaign-bid">${_("bid")}</th>
                %endif
                <th class="campaign-target" title="${targeting_title}">${_("targeting")}</th>
                <th class="campaign-location">${_("location")}</th>
                %if c.user_is_sponsor:
                  <th class="campaign-payment-mismatch">${_("payment mismatch")}</th>
                %endif
                <th class="campaign-buttons" style="align:right"></th>
              </tr>
            </thead>
            <tbody>
              %for camp in thing.campaigns:
                ${camp}
              %endfor
            </tbody>
          </table>
        </div>

        <span class="freebie error"></span>
      </div>
    
</%def>

<%def name="creative_editor()">
  <div class="pretty-form promotelink-editor editor collapsed" id="promo-form">
    <input type="hidden" name="link_id36" value="${thing.link._id36}">

    <input name="kind" value="${'self' if thing.link.is_self else 'link'}" type="hidden">
    
    <div class="collapsed-display">
      ${thing.listing}

      <footer class="buttons">
        <button name="edit-promotion" onclick="return edit_promotion()">edit creative</button>
      </footer>
    </div>
    <div class="uncollapsed-display" style="display:none">
      <div class="editor-group">
        ${pr.image_field(thing.link)}
        <% is_link = not thing.link.is_self %>
        ${pr.title_field(thing.link)}
        ${pr.content_field(thing.link, enable_override=c.user_is_sponsor,
                           tracker_access=c.user_can_track_ads)}
        ${utils.error_field("NO_CHANGE_KIND", "kind", "div")}
        
        ${pr.commenting_field(thing.link)}

        %if c.user_is_sponsor:
          ${pr.managed_field(thing.link)}
          ${pr.media_field(thing.link)}
        %endif
      </div>
      <footer class="buttons">
        ${utils.error_field("RATELIMIT", "ratelimit")}
        &#32;
        <span class="status error"></span>
        ${utils.error_field("RATELIMIT", "ratelimit")}
        <button name="cancel" class="btn" type="button"
                onclick="return cancel_edit_promotion()">cancel</button>
        <button name="save" class="btn primary-button" type="button"
                onclick="return post_pseudo_form('#promo-form', 'edit_promo')">
          ${_("save")}
        </button>
      </footer>
    </div>
  </div>
</%def>