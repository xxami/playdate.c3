module hello_world;

import std::io;
import playdate;

ZString fontpath = "/fonts/Asheville-Sans-14-Bold.pft";
LCDFont* font;

fn int eventHandler(
	PlaydateAPI* api, 
	PDSystemEvent event, 
	uint arg) @export("eventHandler") {
	
	if (event == PDSystemEvent.EVENT_INIT) {
		api.system.log_to_console("hello from c3");

		SDFile* fh = api.file.open("/fonts/Asheville-Sans-14-Bold.pft", FileOptions.FILE_READ);

		if (fh == null) {
			api.system.log_to_console("font not found");
			api.file.close(fh);
		}
		else {
			api.system.log_to_console("font found");
		}

		char* err = null;
		font = api.graphics.load_font(fontpath, &err);
		if (font == null) {
			api.system.log_to_console(err);
			api.system.error("Couldn't load font %s:%s", fontpath, err);
		}
		
		api.system.set_update_callback(&update, api);
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

	// why does this not clear the screen?
	api.graphics.clear(LCDSolidColor.COLOR_WHITE.ordinal);

	// todo: fix load_font
	//api.graphics.set_font(font);
	//ZString s = "Hello C3 World!";
	//api.graphics.draw_text(s, s.len(), PDStringEncoding.ENCODING_ASCII, x, y);

	x += dx;
	y += dy;

	if (x < 0 || x > playdate::LCD_COLUMNS - TEXT_WIDTH) {
		dx = -dx;
	}
	if (y < 0 || y > playdate::LCD_ROWS - TEXT_HEIGHT) {
		dy = -dy;
	}

	api.graphics.draw_rect(x, y, 86, 16, LCDSolidColor.COLOR_BLACK.ordinal);
	
	api.system.draw_fps(0, 0);
	return 1;
}

