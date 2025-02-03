
module playdate;

distinct LCDFont = void;

def LoadFontFn = fn LCDFont*(char* path, char** outErr);

struct PlaydateGraphics {
	LoadFontFn loadFont; 
}

struct PlaydateAPI {
	//struct playdate_sys* system;
	PlaydateGraphics* graphics;
}

enum PDSystemEvent : int {
	EVENT_INIT,
	EVENT_INIT_LUA,
	EVENT_LOCK,
	EVENT_UNLOCK,
	EVENT_PAUSE,
	EVENT_RESUME,
	EVENT_TERMINATE,
	EVENT_KEY_PRESSED,
	EVENT_KEY_RELEASED,
	EVENT_LOW_POWER
}

