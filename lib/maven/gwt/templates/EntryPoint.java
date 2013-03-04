/*
 * Copyright (C) 2013 Christian Meier
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package <%= base_package %>;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.core.client.GWT;
<% if options[:gin] -%>
import com.google.gwt.inject.client.GinModules;
import com.google.gwt.inject.client.Ginjector;
<% end -%>
<% if options[:place] -%>
import com.google.gwt.place.shared.PlaceHistoryHandler;
<% end -%>
<% if options[:gwt_ruby] -%>

import <%= gwt_rails_package %>.Application;
import <%= gwt_rails_package %>.dispatchers.DefaultDispatcherSingleton;
<% end -%>

import org.fusesource.restygwt.client.Defaults;

/**
 * Entry point classes define <code>onModuleLoad()</code>.
 */
public class <%= application_class_name %>EntryPoint implements EntryPoint {
<% if options[:gin] -%>

    @GinModules(<%= application_class_name %>GinModule.class)
    static public interface <%= application_class_name %>Ginjector extends Ginjector {
<% if options[:place] -%>
        PlaceHistoryHandler getPlaceHistoryHandler();
<% end -%>
        Application getApplication();
    }
<% end -%>

    /**
     * This is the entry point method.
     */
    public void onModuleLoad() {
        Defaults.setServiceRoot(GWT.getModuleBaseURL().replaceFirst("[a-zA-Z0-9_]+/$", ""));
<% if options[:gwt_ruby] -%>
        Defaults.setDispatcher(DefaultDispatcherSingleton.INSTANCE);
<% end -%>
        GWT.log("base url for restservices: " + Defaults.getServiceRoot());
<% if options[:gin] -%>

        final <%= application_class_name %>Ginjector injector = GWT.create(<%= application_class_name %>Ginjector.class);

        // setup display
        injector.getApplication().run();
<% if options[:place] -%>
    
        // Goes to the place represented on URL else default place
        injector.getPlaceHistoryHandler().handleCurrentHistory();
<% end -%>
<% else -%>
        new <%= application_class_name %>Application().run();
<% end -%>
    }
}
