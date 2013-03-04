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
