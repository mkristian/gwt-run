package demo.client;


import com.google.gwt.core.client.GWT;
import com.google.gwt.uibinder.client.UiBinder;
import com.google.gwt.uibinder.client.UiField;
import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.Widget;
import com.google.gwt.user.client.ui.RootPanel;

public class DemoApplication extends Composite {

    interface Binder extends UiBinder<Widget, DemoApplication> {}

    private static Binder BINDER = GWT.create(Binder.class);

    DemoApplication(){
        initWidget( BINDER.createAndBindUi( this ) );
    }

    public void run() {
        RootPanel.get().add(this.asWidget());
    }
}
