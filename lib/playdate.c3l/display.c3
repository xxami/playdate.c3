module playdate;

struct PlaydateDisplay {
	GetWidth get_width;
	GetHeight get_height;

	SetRefreshRate set_refresh_rate;

	SetInverted set_inverted;
	SetScale set_scale;
	SetMosaic set_mosaic;
	SetFlipped set_flipped;
	SetOffset set_offset;
}

def GetWidth = fn int();
def GetHeight = fn int();

def SetRefreshRate = fn void(float rate);

def SetInverted = fn void(int flag);
def SetScale = fn void(uint s);
def SetMosaic = fn void(uint x, uint y);
def SetFlipped = fn void(int x, int y);
def SetOffset = fn void(int x, int y);
