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
<%namespace file="utils.m" import="error_field" />

<%def name="report_form_base(fullname, rules_page_link)">
    <form id="report-action-form"
            class="subreddit-report-form rounded">
        <input type="hidden"
                name="thing_id"
                value="${fullname}">
        <a href="${rules_page_link}"
                class="action-icon action-icon-info c-hide-text may-blank"
                title="${_('View the community rules')}">
            ${_('View the community rules')}
        </a>
        <div class="reason-prompt report-header">
            ${_("What rule does this break?")}
        </div>

        ${caller.body()}

        <div class="c-submit-group">
            <button type="button" class="btn c-btn c-btn-secondary report-cancel">
                ${_("cancel")}
            </button>&#32;
            <button type="submit" class="btn c-btn c-btn-primary submit-action-thing" disabled>
                ${_("report")}
            </button>
        </div>
        <span class="status" style="display: none"></span>
    </form>
</%def>

<%def name="subreddit_report_form(fullname, system_rules, rules, sr_name)">
    <%
        rules_page_link = "/%s/%s/about/rules" % (g.brander_community_abbr, sr_name)
    %>
    <%self:report_form_base
            fullname="${fullname}"
            rules_page_link="${unsafe(rules_page_link)}"
            >
        <ol class="report-reason-list">
            %if rules:
                %for rule in rules:
                    ${self.report_form_reason(rule.get("short_name"))}
                %endfor
            %endif
            <li class="report-reason-item report-reason-reddit" 
                <label>
                    <input type="radio"
                            class="site-reason-radio"
                            name="reason"
                            value="site_reason_selected">
                    <div class="report-reason-display">
                        <select name="site_reason">
                            %for rule in system_rules:
                                <option value="${rule}">
                                    ${g.brander_site + _(" rule: %(rule_name)s" % dict(rule_name=rule))}
                                </option>
                            %endfor
                        </select>
                    </div>
                </label>
            </li>
            ${self.report_form_reason_other()}
            <div class="report-header">
                ${_("Reports go to community moderators anonymously")}
            </div>
        </ol>
    </%self:report_form_base>
</%def>

<%def name="reddit_report_form(fullname, system_rules, sr_name=None)">
    <%self:report_form_base
            fullname="${fullname}"
            rules_page_link="/help/contentpolicy"
            >
        <ol class="report-reason-list">
            %for rule in system_rules:
                ${self.report_form_reason(rule)}
            %endfor
            ${self.report_form_reason_other()}
        </ol>
        <div class="report-header">
            %if sr_name:
                ${_("Reports go to community moderators anonymously")}
            %else:
                ${_("Reports go to Reddit admins")}
            %endif
        </div>
    </%self:report_form_base>
</%def>

<%def name="report_form_reason_other()">
    <li class="report-reason-item report-reason-other">
        <label>
            <input type="radio"
                    name="reason"
                    value="other">
            <div class="report-reason-display">
                <div>
                    ${_("Other (max %(num)s characters):") % dict(num=100)}
                </div>
                <input type="text"
                        class="c-form-control"
                        name="other_reason"
                        value=""
                        maxlength="100"
                        disabled>
                ${error_field("TOO_LONG", "other_reason", "span")}
            </div>
        </label>
    </li>
</%def>

<%def name="report_form_reason(rule)">
    <li class="report-reason-item">
        <label>
          <input type="radio" name="reason" value="${rule}">
          <div class="report-reason-display">${rule}</div>
        </label>
    </li>
</%def>

%if thing.rules:
    ${self.subreddit_report_form(
        fullname=thing.thing_fullname,
        rules=thing.rules,
        system_rules=thing.system_rules,
        sr_name=thing.sr_name,
    )}
%else:
    ${self.reddit_report_form(
        fullname=thing.thing_fullname,
        system_rules=thing.system_rules,
    )}
%endif
