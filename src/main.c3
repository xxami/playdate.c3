module hello_world;

import std::io;
import playdate;

char* fontpath = "/System/Fonts/Asheville-Sans-14-Bold.pft";
LCDFont* font;

fn int eventHandler(
	PlaydateAPI* api, 
	PDSystemEvent event, 
	uint arg) @export("eventHandler") {
	
	if (event == PDSystemEvent.EVENT_INIT) {
		api.system.log_to_console("hello from c3");

		char* err = null;
		font = api.graphics.load_font(fontpath, &err);
		if (font == null) {
			api.system.error("Couldn't load font %s:%s", fontpath, err);
		}
		else {
			api.system.set_update_callback(&update, api);
		}
	}
	return 0;
}

const int TEXT_WIDTH = 86;
const int TEXT_HEIGHT = 16;

int x = (400-TEXT_WIDTH)/2;
int y = (240-TEXT_HEIGHT)/2;

int dx = 1;
int dy = 2;

fn int update(void* userdata) {
	PlaydateAPI* api = userdata;

	api.graphics.clear(LCDSolidColor.COLOR_WHITE.ordinal);
	api.graphics.set_font(font);
	ZString s = "Hello C3 World!";
	api.graphics.draw_text(s, s.len(), PDStringEncoding.ENCODING_ASCII, x, y);

	x += dx;
	y += dy;

	if (x < 0 || x > playdate::LCD_COLUMNS - TEXT_WIDTH) {
		dx = -dx;
	}
	if (y < 0 || y > playdate::LCD_ROWS - TEXT_HEIGHT) {
		dy = -dy;
	}
	
	api.system.draw_fps(0, 0);
	return 1;
}

