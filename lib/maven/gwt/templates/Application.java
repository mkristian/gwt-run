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
