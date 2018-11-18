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

<%namespace file="utils.m" import="error_field"/>

<%def name="status_radio(val, datehex, current)">
  <input id="status-${datehex}-${val}"
         class="nomargin" type="radio" value="${val}" name="status"
         ${"checked='checked'" if current == val else ''} />
  <label class="${val}" for="status-${datehex}-${val}">${val}</label>
</%def>

<div class="error-logs">
  %for date, groupings in thing.date_summaries:

  <div class="error-log">
    <a class="date" href="#"
       onclick="$(this).parent().find('.rest').toggle();return false">
      ${date}
    </a>

    <div class="rest">
      %for gr in groupings:
        %if gr[0] > 0:
          ${exception(date, *gr)}
        %else:
          ${text(date, *gr)}
        %endif
      %endfor
    </div>
  </div>
  %endfor
</div>

<%def name="exception(date, frequency, hexkey, d)">
  <% datehex = "-".join([date.replace("/",""), hexkey]) %>

  <div class="exception ${thing.statuses[hexkey]} rounded">
    <a class="frequency hover" href="#"
       onclick="$(this).parent().find('.occurrences').toggle();return false">
      ${frequency} occurrences
    </a>

    <span class="${thing.statuses[hexkey]}">
      ${thing.statuses[hexkey]}:
    </span>

    <a class="nickname" name="${datehex}" href="#${datehex}"
       onclick="$(this).parent().find('.edit-area').toggle();return false">
      ${thing.nicknames[hexkey]}
    </a>

    <br/>

    <div class="edit-area" style="display: none">
      <form action="/post/edit_error" method="post"
          onsubmit="return post_form(this, 'edit_error');"
            id="nickname-${hexkey}">

        <input type="hidden" name="hexkey" value="${hexkey}" />

        <table>
          <tr>
            <th>
            nickname:
            </th>
            <td>
              <input type="text" value="${thing.nicknames[hexkey]}" name="nickname"/>
            </td>
          </tr>
          <tr>
            <th>
              status:
            </th>
            <td>
              ${status_radio("new"   , datehex, thing.statuses[hexkey])}
              ${status_radio("severe", datehex, thing.statuses[hexkey])}
              ${status_radio("interesting", datehex, thing.statuses[hexkey])}
              ${status_radio("normal", datehex, thing.statuses[hexkey])}
              ${status_radio("fixed" , datehex, thing.statuses[hexkey])}
            </td>
          </tr>
          <tr>
            <td>
              <button class="save-button" type="submit">
                save
              </button>
            </td>
            <td>
              ${error_field("NO_TEXT", "codename", "span")}
              <span class="status"></span>
            </td>
          </tr>
        </table>
      </form>
    </div>

    <a class="hover" href="#"
       onclick="$(this).parent().find('.stacktrace').toggle();return false">

      <span class="exception-name">
        ${d['exception']}
      </span>

      <span class="hexkey">(${hexkey})</span>

    </a>

    <div class="occurrences" style="display: none">
    %for o in d['occurrences']:
      <span class="occurrence">
        ${o}
      </span>
      &#32;
    %endfor
    </div>

    <table class="stacktrace lined-table wide" style="display: none">
      <thead>
        <tr>
          <th>file</th>
          <th>line#</th>
          <th>func</th>
          <th>code</th>
        </tr>
      </thead>
      <tbody>
        %for row in d['traceback']:
            <tr>
              %for i, col in enumerate(row):
                <td class="col-${i}">
                  %if i == 2:
                    ${col}()
                  %else:
                    ${col}
                  %endif
                </td>
              %endfor
            </tr>
        %endfor
      </tbody>
    </table>
  </div>
</%def>

<%def name="textocc(text, occ, hide)">
  %if hide:
  <tr class="extra-occs" style="display: none">
  %else:
  <tr>
  %endif
    <td class="actual-text">
      ${text}
    </td>
    <td class="occ">
      ${occ}
    </td>
  </tr>
</%def>

<%def name="text(date, sort_order, level, classification, textoccs)">
<div class="logtext ${level}">
  <span class="loglevel rounded">
    ${level}:
  </span>
  <span class="classification">
    ${classification}
  </span>
  <table class="lined-table wide">
    %for i, (text, occ) in enumerate (textoccs):
      %if i < 3 or i >= len(textoccs) - 3:
        ${textocc(text, occ, False)}
      %elif i == 3:
        <tr class="extra-occs">
          <td colspan="2" class="dotdotdot">
            <a href="#" 
               onclick="$(this).closest('table').find('.extra-occs').toggle();return false">
              <b>...</b>
              &#32;
              (${len(textoccs) - 6} more lines)
            </a>
          </td>
        </tr>

        ${textocc(text, occ, True)}
      %else:
        ${textocc(text, occ, True)}
      %endif
    %endfor
  </table>
</div>
</%def>
