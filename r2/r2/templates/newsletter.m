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
  from r2.lib.template_helpers import make_url_https, static
  from r2.models.admintools import wiki_template
%>
<%namespace file="less.m" import="less_stylesheet"/>
<%namespace file="utils.m" import="form_group, md" />

<%inherit file="reddit.m"/>

<%def name="Title()">
${_('reddit newsletter - upvoted weekly')}
</%def>

<%def name="viewport()">
<meta name="viewport" content="width=device-width, initial-scale=1">
</%def>

<%def name="bodyContent()">

<section class="newsletter-box newsletter-container">
  <header>
    <h1 class="subscribe-callout">${_("subscribe to reddit's official newsletter,")}&#32;<span class="upvoted-weekly-logo"><span class="screenreader-only">${_('upvoted weekly')}</span></span></h1>
    <div class="subscribe-thanks"><img src="${static('subscribe-header-thanks-black.svg')}" alt="_('thanks for subscribing')" /></div>
    <h2 class="result-message">
      ${_("Enter your email to get the very best of reddit's content curated, packaged, and delivered to your inbox once a week. It's free and we'll never spam you.")}
    </h2>
    <div class="subscribe-thanks"><a href="/" class="c-btn c-btn-primary">${_('back to reddit')}</a></div>
  </header>
  <form class="newsletter-signup form-v2 c-form-inline" method="post" action="${make_url_https('/api/newsletter.json')}">
    <input type="hidden" name="uh" value="${c.modhash}" />
    <input type="hidden" name="source" value="standalone">
    <%call expr="form_group('email', 'BAD_EMAIL', show_errors=True, feedback_inside_input=True)">
      <label for="email" class="screenreader-only">${_('email')}:</label>
      <input value=""
             name="email"
             class="c-form-control"
             type="email"
             placeholder="${_('enter your email')}"
             data-validate-url="/api/check_email.json"
             data-validate-on="change blur">
    </%call>
    <button type="submit" class="c-btn c-btn-primary">${_('subscribe')}</button>
  </form>

  <a class="faq-toggle" href="#">${_('More Info')}&#32;</a>

  <div class="faq md">
  <%
    md(wiki_template('newsletter_faq'))
  %>
  </div>
</section>

<div class="upvoted-gradient" role="presentation"></div>

</%def>
