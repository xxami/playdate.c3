module playdate;

struct PlaydateSystem {
	ReAlloc realloc;
	FormatString formatString;
	LogToConsole logToConsole;
	Error error;
	GetLanguage getLanguage;
	GetCurrentTimeMilliseconds getCurrentTimeMilliseconds;
	GetSecondsSinceEpoch getSecondsSinceEpoch;
	DrawFPS drawFPS;
	
	SetUpdateCallback setUpdateCallback;
	GetButtonState getButtonState;
	SetPeripheralsEnabled setPeripheralsEnabled;
	GetAccelerometer getAccelerometer;
}

enum PDButtons : int (int bit_state) {
	BUTTON_LEFT = 1<<0,
	BUTTON_RIGHT = 1<<1,
	BUTTON_UP = 1<<2,
	BUTTON_DOWN = 1<<3,
	BUTTON_B = 1<<4,
	BUTTON_A = 1<<5
}

enum PDLanguage : int {
	LANGUAGE_ENGLISH,
	LANGUAGE_JAPANESE,
	LANGUAGE_UNKNOWN
}

struct PDDateTime {
	ushort year;
	char month;
	char day;
	char weekday;
	char hour;
	char minute;
	char second;
}

distinct PDMenuItem = void;

enum PDPeripherals : int (int bitstate) {
	NONE = 0,
	ACCELEROMETER = 1<<0,
	ALL_PERIPHERALS = 0xffff
}

def PDCallback = fn int(void* userdata);
def PDMenuItemCallback = fn void(void* userdata);
def PDButtonCallback = fn int(PDButtons button, int down, uint when, void* userdata);

def ReAlloc = fn void*(void* ptr, usz size);
def FormatString = fn int(char** ret, char *fmt, ...);
def LogToConsole = fn void(char* fmt, ...);
def Error = fn void(char *fmt, ...);
def GetLanguage = fn PDLanguage();
def GetCurrentTimeMilliseconds = fn int();
def GetSecondsSinceEpoch = fn int(uint *milliseconds);
def DrawFPS = fn void(int x, int y);

def SetUpdateCallback = fn void(PDCallback update, void* userdata);
def GetButtonState = fn void(PDButtons* current, PDButtons* pushed, PDButtons* released);
def SetPeripheralsEnabled = fn void(PDPeripherals mask);
def GetAccelerometer = fn void(float* outx, float* outy, float* outz);

