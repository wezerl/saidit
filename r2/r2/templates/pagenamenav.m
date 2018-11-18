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

<%namespace file="utils.m" import="plain_link, _md"/>

<%def name="subreddit()">
  <span class="hover pagename redditname">
    ${plain_link(c.site.name, c.site.user_path, _sr_path=False)}
    % if hasattr(thing, "title"):
      : ${thing.title}
    % endif
  </span>
</%def>

<%def name="domain()">
  <div id="sr-name-box">
    <span class="hover pagename redditname">
      ${plain_link(getattr(c.site, "idn", c.site.name), c.site.user_path, _sr_path=False)}
      % if hasattr(thing, "title"):
        : ${thing.title}
      % endif
    </span>
    % if hasattr(c.site, "idn"):
    <span class="help help-hoverable tooltip">
      ${c.site.name}
      <div id="idn-help" class="hover-bubble help-bubble anchor-top-left">
        <div class="help-section help-idn">
          <p>
            ${_md("This is an [internationalized domain name](http://en.wikipedia.org/wiki/Internationalized_domain_name).  We've modified how it is displayed [for security reasons](http://en.wikipedia.org/wiki/IDN_homograph_attack).")}
          </p>
        </div>
      </div>
    </span>
    % endif
  </div>
</%def>

<%def name="subreddits()">
  <span class="hover pagename redditname">
    ${plain_link(_("subs"), "/subs/", _sr_path=False)}
  </span>
</%def>

<%def name="nomenu()">
<span class="pagename selected">${thing.title}</span>
</%def>

<%def name="help()">
  <span class="hover pagename redditname">
    ${plain_link(thing.title, "/wiki", _sr_path=False)}
  </span>
</%def>

<%def name="newpagelink()">
<span class="newpagelink">reddit all?&#32;${plain_link("click here to find new links.", "/new/", _sr_path=False)}</span>
</%def>

<%def name="subredditnositelink()">
  <span class="hover pagename redditname">
    % if hasattr(thing, "title"):
      ${thing.title}
    % endif
  </span>
</%def>

<%def name="subredditheadertitle()">
  <span class="hover pagename redditname">
    ${plain_link(c.site.header_title, c.site.user_path, _sr_path=False)}
    % if hasattr(thing, "title"):
      : ${thing.title}
    % endif
  </span>
</%def>
