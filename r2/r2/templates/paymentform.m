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

<div class="payment-setup">
  <h1>${_("set up payment for this link")}</h1>
  <form method="POST" action="/post/pay" id="pay-form"
        class="pretty-form"
        onsubmit="return post_form(this, 'update_pay')">
    <p>
      ${_("The duration of this link is %(duration)s (from %(start)s to %(end)s).") % dict(duration=thing.duration, start=thing.start_date, end=thing.end_date)}
    </p>
    <p id="bid-field">
      <input type="hidden" name="campaign" value="${thing.campaign_id36}" />
      <input type="hidden" name="link" value="${thing.link._fullname}" />
      ${_("Your current budget is %(budget)s") % dict(budget=thing.budget)}
      ${error_field("OVERSOLD_DETAIL", "bid", "div")}
  </p>
  %if thing.profiles:
  <p>
    ${_("Please pick your credit card:")}
    <select onchange="change_address(this)" name="account">
      <option value="0">${_("select...")}</option>
      %for profile in thing.profiles:
        <option value="${profile.customerPaymentProfileId}">
          Card: ${profile.payment.creditCard.cardNumber}
        </option>
      %endfor
      %if len(thing.profiles) >= thing.max_profiles:
        <option disabled=true>${_("profile limit (%d) reached" % thing.max_profiles)}</option>
      %else:
        <option value="">${_("create a new one...")}</option>
      %endif
    </select>
  </p>
  %else:
    <p class="info">
      ${_("please create a new payment profile")}
    </p>
  %endif
  <p class="info">
   ${_("NOTE: your card will not be charged until the campaign has been queued "
       "for promotion.")}
  </p>
    <input type="hidden" name="customer_id" value="${thing.customer_id}" />
    
    ${profile_info(None, disabled=bool(thing.profiles))}
    %for profile in thing.profiles:
      ${profile_info(profile, disabled=True)}
    %endfor
  </form>
  
  <script type="text/javascript">
    function enable_all(elem) {
       $(elem).parents("div.pay-form").addBack()
             .find("[disabled]").removeAttr("disabled").end()
             .find("table").removeClass("disabled").end()
             .find("[name=edit]").val("on");
       return false;
    }
    function disable_all(elem) {
       var what = $(elem).parents("div.pay-form").addBack()
                     .find("table").addClass("disabled")
                     .find(":input").not("button")
                     .attr("disabled", "disabled");
       return false;
    }
    function change_address(what) {
       var val = $(what).val();
       var inputs = $(".pay-form").not("#form-option-" + val).hide()
                       .each(function() { disable_all(this); })
                       .end()
                       .filter("#form-option-" + val).show();
       if (val == "" || inputs.find("[name=edit]").val() == "on") 
            enable_all(inputs);
    }

    (function($) {
      $.payment_redirect = function(url, isNewCard, amount) {
        r.analytics.fireFunnelEvent('ads', isNewCard ? 'checkout-new' : 'checkout-existing');
        r.analytics.fireFunnelEvent('ads', 'checkout-pay', {value: amount}, function() {
          window.location.href = url;
        });
      };
    })(window.jQuery);
  </script>
</div>

<%def name="profile_info(profile, disabled=False)">
   <%
      address = ((_("first name") , "firstName", ""),
                 (_("last name")  , "lastName", ""),
                 (_("company")    , "company", _("(optional)")),
                 (_("address")    , "address", ""),
                 (_("city")       , "city", ""),
                 (_("state")      , "state", ""),
                 (_("zip")        , "zip", ""),
                 (_("country")    , "country", ""),
                 (_("phone")      , "phoneNumber", _("(optional)")))
      cc      = ((_("card number")     , "cardNumber", _("(14-17 digits)")),
                 (_("expiration date") , "expirationDate", "(YYYY-MM please)"),
                 (_("CCV")             , "cardCode", _("(3 or 4 digits)")))
      bill_to = getattr(profile, "billTo",None)
      credit  = getattr(profile, "payment", None)
      credit  = getattr(credit,  "creditCard", None)
      prof_id = getattr(profile, "customerPaymentProfileId", "")
      display  = "style='display:none'" if disabled else ''
      disabled = "disabled" if disabled else ""
    %>
   <div id="form-option-${prof_id}" class="pay-form" ${display}>
   %if profile:
     <input type="hidden" name="pay_id" ${disabled}
            value="${prof_id}" />
   %endif
   <input type="hidden" name="edit" ${disabled}
          value="${'off' if profile else 'on'}" />
   <table class="content preftable ${'disabled' if disabled else ''}">
     %for fields, data, error_name in ((address, bill_to, "BAD_ADDRESS"), (cc, credit, "BAD_CARD")):
     %for label, field, optional in fields:
     <tr class="payment-${field.lower()}" 
         id="payment-${field.lower()}-${prof_id}">
       <th><label for="input-${field}-${prof_id}">
         ${label}
       </label></th>
       <td>
         %if field == "address":
           <textarea ${disabled} id="input-${field}-${prof_id}" name="${field}">
             ${getattr(data, field, '')}
           </textarea>
         %elif field == "country":
           <%
            selected_country = getattr(data, field, thing.default_country)
            selected_insensitive = selected_country.lower()
           %>
           %if any(map(lambda country: country.lower() == selected_insensitive, thing.countries)):
            <select ${disabled} id="input-${field}-${prof_id}" name="${field}">
              %for country in thing.countries:
                <option ${"selected" if selected_insensitive == country.lower() else ""}>${country}</option>
              %endfor
            </select>
           %else:
            <input type="text" ${disabled} id="input-${field}-${prof_id}" name="${field}" value="${selected_country}">
           %endif
         %else:
           <input ${disabled}
                  id="input-${field}-${prof_id}" type="text" name="${field}" 
                  value="${getattr(data, field, '')}" />
         %endif
         %if optional:
           <span class="optional">${optional}</span>
         %endif
       </td>
       <td>
         ${error_field(error_name, field)}
       </td>
     </tr>
     %endfor
     %endfor
     <tr>
       <td></td>
       <td>
         <button type="submit">${_("authorize payment")}</button>
         %if disabled and profile:
            <button onclick="$(this).hide();return enable_all(this);">
              ${_("edit")}
            </button>
         %endif
       </td>
     </tr>       
     <tr>
       <td></td>
       <td>
         <span class="status"></span>
       </td>
     </tr>
   </table>
   </div>
</%def>
