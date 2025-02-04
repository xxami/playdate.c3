module hello_world;

import std::io;
import playdate;

char* fontpath = "/System/Fonts/Asheville-Sans-14-Bold.pft";
LCDFont* font;

fn int eventHandler(PlaydateAPI* api, PDSystemEvent event, uint arg) {
	if (event == PDSystemEvent.EVENT_INIT) {
		char* err;
		font = api.graphics.loadFont(fontpath, &err);
	}
	return 0;
}
