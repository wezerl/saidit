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
    from r2.lib.template_helpers import static
%>
<%namespace file="utils.m" import="error_field" />
  <%
    additional_cls = ""
    if not feature.is_enabled("subreddit_rules", subreddit=c.site.name):
        additional_cls = "report-action-form"
  %>
  <form id="report-action-form" class="action-form ${additional_cls} rounded" data-form-action="report">
    <input type="hidden" name="thing_id" value="${thing.thing_fullname}">
    <span class="reason-prompt">
      ${_("why are you reporting this?")}
    </span>
    <ol>
      %for rule in thing.rules:
        <li>
          <label>
            <input type="radio" name="reason" value="${rule}">${rule}
          </label>
        </li>
      %endfor
      %if thing.system_rules:
        <li>
          <label>
            <input type="radio" name="reason" value="site_reason_selected">
            <select name="site_reason">
              %for rule in thing.system_rules:
                <option value="${rule}">${g.brander_site + _(" rule: %(rule_name)s" % dict(rule_name=rule))}</option>
              %endfor
            </select>
          </label>
        </li>
      %endif
      <li>
        <label>
          <input type="radio" name="reason" value="other">${_("other (max %(num)s characters):") % dict(num=100)}
        </label>
        <input name="other_reason" value="" maxlength="100" type="text" disabled>
      </li>
    </ol>
    <button type="submit" class="btn submit-action-thing" disabled>
      ${_("submit")}
    </button>
    <button type="button" class="btn cancel-action-thing report-cancel">
      ${_("cancel")}
    </button>
    <span class="status"></span>
    ${error_field("TOO_LONG", "reason", "span")}
  </form>
