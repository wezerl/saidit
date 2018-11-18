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
   from r2.config import feature
   from r2.lib.filters import unsafe, safemarkdown
   from r2.lib.template_helpers import static, format_number, display_comment_karma, display_link_karma
 %>
<%namespace file="utils.m" import="submit_form, plain_link, thing_timestamp"/>
<%namespace file="printablebuttons.m" import="toggle_button"/>

<div class="titlebox">
  <h1>${thing.user.name}
    %if thing.user.employee:
      <span class="user-distinction">
        [
        <span class="admin" title="saidit admin">A</span>
        ]
      </span>
    %endif
  </h1>

  %if c.user_is_loggedin and not thing.viewing_self:
    <div>
    ${toggle_button("fancy-toggle-button", _("+ friends"), _("- friends"),
         "friend('%s', '%s', 'friend')" % (thing.user.name, c.user._fullname),
         "unfriend('%s', '%s', 'friend')" % (thing.user.name, c.user._fullname),
         css_class = "add", alt_css_class = "remove",
         reverse = thing.is_friend, login_required=True)}
    </div>
  %endif

  <span class="karma">${format_number(display_link_karma(thing.user.link_karma))}</span>
  &#32;
  ${_("post karma")}

  <br/>
  <span class="karma comment-karma">${format_number(display_comment_karma(thing.user.comment_karma))}</span>
  &#32;
  ${_("comment karma")}

  %if thing.show_private_info:
    <table id="per-sr-karma"${" class='more-karmas'" if not c.user_is_admin else ""}>
     <thead>
        <tr>
          <th id="sr-karma-header">sub</th>
          <th>post</th>
          <th>comment</th>
        </tr>
     </thead>
     <tbody>
     %for i, (sr_name, (link_karma, comment_karma)) in enumerate(thing.all_karmas.iteritems()):
       %if c.user_is_admin and i >= 5:
         <tr class="more-karmas">
       %else:
         <tr>
       %endif

        % if sr_name == "ancient history":
          <th class="helpful" title="${_('really obscure karma from before it was cool to track per-sub')}"><span>${_(sr_name)}</span></th>
        % else:
          <th>${sr_name}</th>
        % endif

          <td>${display_link_karma(link_karma)}</td>
          <td>${display_comment_karma(comment_karma)}</td>
        </tr>
     %endfor
     </tbody>
    </table>
    % if not c.user_is_admin or len(thing.all_karmas) > 5:
    <div class="karma-breakdown">
      <a href="javascript:void(0)"
         onclick="$('.more-karmas').show();$(this).hide();return false">
         show karma breakdown by sub
      </a>
    </div>
    % endif
  %endif

  %if thing.user.gold:
    %if thing.show_private_info or thing.user.pref_show_snoovatar:
      <div class="gold-accent snoovatar-link">
        <a href="/user/${thing.user.name}/snoo">
          %if thing.viewing_self:
            ${_("View/edit my snoovatar")}
          %else:
            ${_("%(username)s's snoovatar") % dict(username=thing.user.name)}
          %endif
        </a>
      </div>
    %endif
  %endif

  %if thing.show_users_gold_expiration or thing.show_private_gold_info:
    <div class="rounded gold-accent gold-expiration-info">
      %if hasattr(thing, "gold_remaining"):
        <div class="gold-remaining" title="${thing.user.gold_expiration.strftime('%Y-%m-%d')}">
          <span class="karma">
            ${thing.gold_remaining}
          </span>
          <br>
          ${_("of gold remaining")}
          <br>
          <a href="/gold/about">${_("view gold features/benefits")}</a>
        </div>
        %if thing.show_private_info:
          %if hasattr(thing, "paypal_subscr_id"):
             <div>
              <a href="${thing.paypal_url}">
                ${_("Recurring Paypal subscription")}
              </a>
              &#32;
              ${thing.paypal_subscr_id}
            </div>
          %endif

          %if hasattr(thing, "stripe_customer_id"):
             <div>
              <a href="/gold/subscription">
                ${_("manage recurring subscription")}
              </a>
            </div>
          %endif
        %endif
      %endif
      %if hasattr(thing, "gold_creddit_message"):
        <div class="gold-creddits-remaining">
          ${plain_link(thing.gold_creddit_message, "/gold?goldtype=gift")}
        </div>
      %endif
      %if hasattr(thing, "num_gildings_message"):
        <div>
          ${thing.num_gildings_message}
        </div>
      %endif
    </div>
  %endif

%if hasattr(thing, "goldlink"):
  <div class="giftgold">
    <a href="${thing.goldlink}" class="access-required"
       data-type="account" data-fullname="${thing.user._fullname}"
       data-event-action="gild">
      ${thing.giftmsg}
    </a>
  </div>
%endif

  <div class="bottom">
    %if not thing.viewing_self:
      <img src="${static('mailgray.png')}"/>
      &#32;
      <a href="${"/message/compose/?to=%s" % thing.user.name}" class="access-required"
         data-type="account" data-fullname="${thing.user._fullname}"
         data-event-action="compose">
        ${_("send a private message")}
      </a>
    %endif

    <span class="age">
      ${_("saiditter for")}&#32;${thing_timestamp(thing.user)}
    </span>
  </div>

  <div class="clear"> </div>

</div>

