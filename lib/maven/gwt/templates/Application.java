package <%= base_package %>;

<% if options[:gin] -%>
import javax.inject.Inject;
import javax.inject.Singleton;
<% end -%>

import com.google.gwt.core.client.GWT;
import com.google.gwt.uibinder.client.UiBinder;
import com.google.gwt.uibinder.client.UiField;
import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.Widget;
import com.google.gwt.user.client.ui.RootPanel;

<% if options[:gin] -%>
@Singleton
<% end -%>
public class <%= application_class_name %>Application extends Composite {

    interface Binder extends UiBinder<Widget, <%= application_class_name %>Application> {}

    private static Binder BINDER = GWT.create(Binder.class);

<% if options[:gin] -%>
    @Inject
<% end -%>
    <%= application_class_name %>Application(){
        initWidget( BINDER.createAndBindUi( this ) );
    }

<% if options[:gwt_ruby] -%>
    @Override
<% end -%>
    public void run() {
        RootPanel.get().add(this.asWidget());
    }
<% if options[:session] -%>

    @Override
    public void startSession(User user) {
    }

    @Override
    public void stopSession() {
    }
 <% end -%>
}
