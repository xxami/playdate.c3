
module playdate;

struct PlaydateAPI {
	PlaydateSystem* system;
	PlaydateFile* file;
	PlaydateGraphics* graphics;
	PlaydateSprite* sprite;
	PlaydateDisplay* display;
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
