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
   from r2.lib.strings import strings
%>

<%namespace file="utils.m" import="md, _mdf"/>
<%namespace file="goldpayment.m" import="stripe_form"/>

<div class="gold-wrap">
  <h1 class="gold-banner"><a href="/gold">${_('reddit gold')}</a></h1>

  <div class="fancy">
    <div class="fancy-inner">
      <div class="fancy-content">
        <div class="gold-form gold-payment">
          <div class="container">
            <h2 class="sidelines"><span>${_('In Summation')}</span></h2>

            <div class="transaction-summary">
              ${md(thing.summary)}
              <div class="gift-message">
                ${md(thing.description, wrap=True)}
              </div>

              ${_mdf(strings.gold_summary_gilding_page_footer, price=thing.price)}

              ${stripe_form(display=True)}
            </div>
          </div>
          <span role="presentation" class="gold-snoo" title="${_('Felicitations on this momentous occasion!')}"></span>
        </div>
      </div>
    </div>
  </div>
</div>
