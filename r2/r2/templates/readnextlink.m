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

<%namespace file="utils.m" import="thumbnail_img, nsfw_stamp" />

<a id="read-next-link-${thing._fullname}" class="read-next-link may-blank" href="${thing.permalink}?ref=readnext">
  <div class="read-next-meta">
    %if not thing.hide_score:
      <span class="score">${thing.score} points</span>&#32;
    %endif
    %if thing.num_comments:
      &middot;&#32;
      <span class="comments">${thing.comment_label}</span>&#32;
    %endif
  </div>
  %if thing.thumbnail:
    ${self.thumbnail()}
  %endif
  <div class="read-next-title">
    %if thing.over_18:
      <span class="nsfw-stamp stamp">${nsfw_stamp()}</span>&#32;
    %endif
    ${thing.title}
  </div>
</a>

<%def name="thumbnail()">
  %if thing.thumbnail and not thing.thumbnail_sprited:
    <div class="read-next-thumbnail">
      ${thumbnail_img(thing)}
    </div>
  %endif
</%def>
