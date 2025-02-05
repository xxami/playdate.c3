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
		api.system.setUpdateCallback(&update, null);
		//char* err = null;
		//font = api.graphics.loadFont(fontpath, &err);
	}
	return 0;
}

fn int update(void* userdata) {
	return 1;
}