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
## All portions of the code written by reddit are Copyright (c) 2006-2012
## reddit Inc. All Rights Reserved.
###############################################################################

<%namespace file="utils.m" import="plain_link, classes, md"/>

<div ${classes("titlebox", "rounded", "filtered-details", thing.css_class)}
     data-path="${c.site.multi_path}">
  <h1 class="hover redditname">
    ${plain_link(c.site.name, c.site.user_path, _sr_path=False, _class="hover")}
  </h1>

  <div class="usertext">
    ${md(_("Displaying content from %s, except the following subreddits: ") % c.site.unfiltered_path, wrap=True)}
  </div>

  <ul class="subreddits">
  %for sr in c.site.exclude_srs:
    <li data-name="${sr.name}">
      <a href="/${g.brander_community_abbr}/${sr.name}" data-name="${sr.name}">/${g.brander_community_abbr}/${sr.name}</a>
      <button class="remove-sr">${_('remove')}</button>
    </li>
  %endfor
  </ul>

  <form class="add-sr">
    <input type="text" class="sr-name" placeholder="${_('filter subreddit')}"><button class="add">${_('add')}</button>
    <div class="error add-error"></div>
  </form>

  ${plain_link(_('View unfiltered %s') % c.site.unfiltered_path, c.site.unfiltered_path, _sr_path=False, _class="unfilter")}
</div>
