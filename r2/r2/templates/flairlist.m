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

<%namespace name="utils" file="utils.m"/>

<div class="flairgrant flairlist">
  <%utils:line_field title="${_('jump to user (or add):')}" css_class="flair-jump">
    <form method="get">
      <% name = thing.user.name if thing.user else thing.name %>
      <input type="text" maxlength="20" id="flair_jump_name" name="name"
             value="${name}">
      <button type="submit">${_('go')}</button>
      ${utils.error_field('USER_DOESNT_EXIST', 'name')}
    </form>
    %if thing.user or thing.name:
        ${utils.plain_link(_('back to full list'), '/about/flair',
                           class_='flairlisthome')}
    %elif thing.after:
        ${utils.plain_link(_('back to the beginning'), '/about/flair',
                           class_='flairlisthome')}
    %endif
  </%utils:line_field>
  <% flair = thing.flair %>
  %if flair:
    <div class="usertable">
      <span class="header tagline">&nbsp;</span>
      <span class="header">${_('flair text')}</span>
      <span class="header">${_('css class')}</span>
      %for row in flair:
          ${unsafe(row.render())}
      %endfor
    </div>
  %endif
</div>
