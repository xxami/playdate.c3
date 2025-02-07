module playdate;

distinct LCDBitmap = void;
distinct LCDFont = void;

def LoadFont = fn LCDFont*(char* path, char** outErr);

struct PlaydateGraphics {
	LoadFont loadFont; 
}
