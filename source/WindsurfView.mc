using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class WindsurfView extends Ui.View {
    function initialize() {
        View.initialize();
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.clear();

        var cx = dc.getWidth() / 2;
        var cy = dc.getHeight() / 2;

        dc.drawText(cx, cy - 35, Gfx.FONT_LARGE, "WINDSURF", Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(cx, cy + 20, Gfx.FONT_MEDIUM, "Hello Garmin", Gfx.TEXT_JUSTIFY_CENTER);
    }
}
