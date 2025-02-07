module playdate;

struct PlaydateSystem {
	ReAlloc realloc;
	FormatString format_string;
	LogToConsole log_to_console;
	Error error;
	GetLanguage get_language;
	GetCurrentTimeMilliseconds get_current_time_milliseconds;
	GetSecondsSinceEpoch get_seconds_since_epoch;
	DrawFPS draw_fps;
	
	SetUpdateCallback set_update_callback;
	GetButtonState get_button_state;
	SetPeripheralsEnabled set_peripherals_enabled;
	GetAccelerometer get_accelerometer;

	GetCrankChange get_crank_change;
	GetCrankAngle get_crank_angle;
	IsCrankDocked is_crank_docked;
	SetCrankSoundsDisabled set_crank_sounds_disabled;

	GetFlipped get_flipped;
	SetAutoLockDisabled set_auto_lock_disabled;

	SetMenuImage set_menu_image;
	AddMenuItem add_menu_item;
	AddCheckmarkMenuItem add_checkmark_menuitem;
	AddOptionsMenuItem add_options_menu_item;
	RemoveAllMenuItems remove_all_menu_items;
	RemoveMenuItem remove_menu_item;
	GetMenuItemValue get_menu_item_value;
	SetMenuItemValue set_menu_item_value;
	GetMenuItemTitle get_menu_item_title;
	SetMenuItemTitle set_menu_item_title;
	GetMenuItemUserdata get_menu_item_userdata;
	SetMenuItemUserdata set_menu_item_userdata;

	GetReduceFlashing get_reduce_flashing;
	GetElapsedTime get_elapsed_time;
	ResetElapsedTime reset_elapsed_time;
	GetBatteryPercentage get_battery_percentage;
	GetBatteryVoltage get_battery_voltage;

	GetTimezoneOffset get_timezone_offset;
	ShouldDisplay24HourTime should_display_24hour_Time;
	ConvertEpochToDateTime convert_epoch_to_date_time;
	ConvertDateTimeToEpoch convert_date_time_to_epoch;
	ClearICache clear_icache;

	SetButtonCallback set_button_callback;
	SetSerialMessageCallback set_serial_message_callback;

	// Ignore this: va_args don't have an equivalent in C3
	DummyPointerForVaFormatString dummy_ptr;

	ParseString parse_string;
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
def PDSerialMessageCallback = fn void(char* data);

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

def GetCrankChange = fn float();
def GetCrankAngle = fn float();
def IsCrankDocked = fn int();
def SetCrankSoundsDisabled = fn int(int flag);

def GetFlipped = fn int();
def SetAutoLockDisabled = fn void(int disable);

def SetMenuImage = fn void(LCDBitmap* bitmap, int xOffset);
def AddMenuItem = fn PDMenuItem*(char* title, PDMenuItemCallback cb, void* userdata);
def AddCheckmarkMenuItem = fn PDMenuItem*(char* title ,int value, PDMenuItemCallback cb, void* userdata);
def AddOptionsMenuItem = fn PDMenuItem*(char* title, char** options, int count, PDMenuItemCallback cb, void *userdata);
def RemoveAllMenuItems = fn void();
def RemoveMenuItem = fn void(PDMenuItem* menuItem);
def GetMenuItemValue = fn int(PDMenuItem* menuItem);
def SetMenuItemValue = fn void(PDMenuItem* menuItem, int value);
def GetMenuItemTitle = fn char*(PDMenuItem* menuItem);
def SetMenuItemTitle = fn void(PDMenuItem* menuItem, char* title);
def GetMenuItemUserdata = fn void*(PDMenuItem* menuItem, char* title);
def SetMenuItemUserdata = fn void(PDMenuItem* menuItem, void *userdata);

def GetReduceFlashing = fn int();
def GetElapsedTime = fn float();
def ResetElapsedTime = fn void();
def GetBatteryPercentage = fn float();
def GetBatteryVoltage = fn float();

def GetTimezoneOffset = fn int();
def ShouldDisplay24HourTime = fn int();
def ConvertEpochToDateTime = fn void(int epoch, PDDateTime* datetime);
def ConvertDateTimeToEpoch = fn int(PDDateTime* datetime);
def ClearICache = fn void();

def SetButtonCallback = fn void(PDButtonCallback cb, void* buttonud, int queuesize);
def SetSerialMessageCallback = fn void(PDSerialMessageCallback cb);
def DummyPointerForVaFormatString = fn int();
def ParseString = fn int(char* str, char* format, ...);
