Javascript Dependency Manager
=============================
This plugin is a basic javascript dependency manager. It makes it simple to specify the dependencies for specific javascript files/libraries and implicitly include them.

Example Usage:  
Add `include JavascriptHelper` in your ApplicationHelper.

    # app/helpers/application_helper.rb
    module ApplicationHelper
      include JavascriptHelper
    end
    
  
Specify any dependencies in a method named `js_dependencies` (optional). Some default dependencies are defined already as a connivence for prototype and scriptaculous.
    
    # app/helpers/application_helper.rb
    module ApplicationHelper
      include JavascriptHelper

      def js_dependencies
        {
          # dialog_box.js requires effects.js and behaviour.js
          :dialog_box => [:effects, :behaviour] 
        }
      end
    end
  
In your layout, add `javascript_tags` in the head of your HTML doc.
  
    # app/views/layouts/default.html.erb
    ...
    <head>
      <%= javascript_tags -%>
    </head>
    ...
  
In your views, when you need to use the dialog_box.js library, just include it using the `js` helper method this plugin provides. The `js` method is an alias for the more verbose `add_javascript_requirement` method.

    # app/views/users/new.html.erb
    <% js :dialog_box %> # you can use a string or symbol for the name.


One caveat to be aware of is when requiring javascript from inside the layout, be careful to place the call to `add_javascript_requirement` before the `javascript_tags` line.
    
    # app/views/layouts/default.html.erb
    <% js :dialog_box %>
    <%= javascript_tags -%>

That's it. It's a work in progress, feel free to contribute at   [http://github.com/arya/js\_dependency\_manager](http://github.com/arya/js_dependency_manager)

  
Using Google AJAX Libraries
===========================
Google provides hosting for popular javascript libraries  
[http://code.google.com/apis/ajaxlibs/documentation/index.html](http://code.google.com/apis/ajaxlibs/documentation/index.html)

Using this plugin, you can opt to use libraries from their server rather than yours.

By default, only local (/public/javascripts/) javascripts are used but if you want to use Google's server, simply add this to an initializer:

    JavascriptHelper::JavascriptHelperConfig.use_google_ajax_libs = true
  
You can put it in your environment files (development/production) to differentiate settings for development mode and production.

You can technically also put it in your application helper after `include JavascriptHelper`, but that's kind of ugly and not recommended.

If you set `use_google_ajax_libs` to `true`, when you do

    js :prototype
  
it will yield

    <script src="http://ajax.googleapis.com/ajax/libs/prototype/1.6.0.2/prototype.js" type="text/javascript"></script>
  
  
Here is a list of the libraries provided by Google:

* jQuery
* prototype
* scriptaculous (builder, effects, dragdrop, controls, slider, sound)
* mootools
* dojo

If you wish to use the compressed version of the library, you can specify that like this:

    JavascriptHelper::JavascriptHelperConfig.google_ajax_libs[:jQuery][:prefer_compressed] = true
  
Note: compressed versions are not provided for prototype or scriptaculous libraries.

By default, the latest versions of the libraries as of the updating of this plugin are used, but you can specify the version you want yourself like so:

    JavascriptHelper::JavascriptHelperConfig.google_ajax_libs[:effects][:version] = "1.8.2"