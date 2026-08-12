using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class WindsurfApp extends App.AppBase {
    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new WindsurfView() ];
    }
}
