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
  from r2.lib.pages import SubscribeButton
  from r2.lib.filters import unsafe, safemarkdown
  from r2.lib.strings import Score
%>

<div class="explore-item explore-${thing.type}" data-sr_name="${thing.sr.name}" data-src="${thing.src}">
  <div class="explore-sr">
    <span class="explore-label">
      <span class="explore-label-type">${_(thing.type)}</span> in 
      <a href="/${g.brander_community_abbr}/${thing.sr.name}" class="explore-label-link" target="_blank">
        /${g.brander_community_abbr}/${thing.sr.name}
      </a>
    </span>
    <span class="explore-sr-details">
      <span>${unsafe(Score.readers(thing.sr._ups))}</span>
    </span>
    <span class="explore-feedback">
      ${SubscribeButton(thing.sr, bubble_class="anchor-left explore-subscribe-bubble")}
      <span class="explore-feedback-dismiss" title="${_('not interested')}">
        ${_("hide")}
      </span>
    </span>
  </div>
  ${thing.link}
  %if thing.comment:
  <div class="comment">
    ${unsafe(safemarkdown(thing.comment.body))}
    <div class="comment-fade"></div>
  </div>
  <a class="comment-link" href="${thing.link.make_permalink(thing.sr)}" target="_blank">
    ${_("more comments")}
  </a>
  %endif
</div>
