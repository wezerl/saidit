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

<%namespace file="utils.m" import="plain_link, post_link" />

<%def name="plain()">
  ${plain_link(thing.selected_title() if thing.selected else thing.title, 
               thing.path, _sr_path = thing.sr_path,
               target = thing.target, 
               _class = thing.css_class, _id = thing._id,
               data=thing.data)}
</%def>

<%def name="js()">
  ${plain_link(thing.selected_title() if thing.selected else thing.title, 
               thing.path, _sr_path = False,
               _class = thing.css_class, _id = thing._id, 
               onclick = thing.onclick,
               data=thing.data)}
</%def>

<%def name="post()">
  ${post_link(thing.selected_title() if thing.selected else thing.title,
              thing.base_path, thing.base_path, thing.action_params,
              _sr_path=thing.sr_path,
              target=thing.target, _class=thing.css_class, _id=thing._id,
              data=thing.data)}
</%def>
