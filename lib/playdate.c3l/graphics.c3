module playdate;

struct LCDRect {
	int left;
	int right;
	int top;
	int bottom;
}

fn LCDRect lcd_make_rect(int x, int y, int width, int height) {
	LCDRect r = { .left = x, .right = x+width, .top = y, .bottom = y+height };
	return r;
}

fn LCDRect lcd_rect_translate(LCDRect r, int dx, int dy) {
	LCDRect rt = { .left = r.left+dx, .right = r.right+dx, .top = r.top+dy, .bottom = r.bottom+dy };
	return rt;
}

const int LCD_COLUMNS = 400;
const int LCD_ROWS = 240;
const int LCD_ROWSIZE = 52;
const LCDRect LCD_SCREEN_RECT = { .left = 0, .right = LCD_COLUMNS, .top = 0, .bottom = LCD_ROWS };

enum LCDBitmapDrawMode : int {
	DRAWMODE_COPY,
	DRAWMODE_WHITE_TRANSPARENT,
	DRAWMODE_BLACK_TRANSPARENT,
	DRAWMODE_FILL_WHITE,
	DRAWMODE_FILL_BLACK,
	DRAWMODE_XOR,
	DRAWMODE_NXOR,
	DRAWMODE_INVERTED
}

enum LCDBitmapFlip : int {
	BITMAP_UNFLIPPED,
	BITMAP_FLIPPED_X,
	BITMAP_FLIPPED_Y,
	BITMAP_FLIPPED_XY
}

enum LCDSolidColor : int {
	COLOR_BLACK,
	COLOR_WHITE,
	COLOR_CLEAR,
	COLOR_XOR
}

enum LCDLineCapStyle : int {
	LINECAPSTYLE_BUTT,
	LINECAPSTYLE_SQUARE,
	LINECAPSTYLE_ROUND
}

enum LCDFontLanguage : int {
	LANGUAGE_ENGLISH,
	LANGUAGE_JAPANESE,
	LANGUAGE_UNKNOWN
}

enum PDStringEncoding : int {
	ENCODING_ASCII,
	ENCODING_UTF8,
	ENCODING_LE16
}

def LCDPattern = char[16];
def LCDColor = uptr;


macro LCDPattern lcd_opaque_pattern($r0, $r1, $r2, $r3, $r4, $r5, $r6, $r7) {
	return { $r0, $r1, $r2, $r3, $r4, $r5, $r6, $r7, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
}

enum LCDPolygonFillRule : int {
	POLYGONFILL_NONZERO,
	POLYGONFILL_EVEN_ODD
}

enum PDTextWrappingMode : int {
	WRAP_CLIP,
	WRAP_CHARACTER,
	WRAP_WORD
}

enum PDTextAlignment : int {
	ALIGNTEXT_LEFT,
	ALIGNTEXT_CENTER,
	ALIGNTEXT_RIGHT
}

distinct LCDBitmap = void;
distinct LCDBitmapTable = void;
distinct LCDFont = void;
distinct LCDFontData = void;
distinct LCDFontPage = void;
distinct LCDFontGlyph = void;
distinct LCDVideoPlayer = void;

struct PlaydateVideo {
	LoadVideo load_video;
	FreePlayer free_player;
	SetContext set_context;
	UseScreenContext use_screen_context;
	RenderFrame render_frame;
	GetError get_error;
	GetInfo get_info;
	GetContext get_context;
}

def LoadVideo = fn LCDVideoPlayer*(char* path);
def FreePlayer = fn void(LCDVideoPlayer* p);
def SetContext = fn int(LCDVideoPlayer* p, LCDBitmap* context);
def UseScreenContext = fn void(LCDVideoPlayer* p);
def RenderFrame = fn int(LCDVideoPlayer* p, int n);
def GetError = fn char*(LCDVideoPlayer* p);
def GetInfo = fn void(LCDVideoPlayer *p, int* width, int* height, float* framerate, int* framecount, int* cur_frame);
def GetContext = fn LCDBitmap*(LCDVideoPlayer* p);

struct PlaydateGraphics {
	PlaydateVideo* video;
	
	SetPixel set_pixel;
	Clear clear;
	SetBackgroundColor set_background_color;
	SetStencil set_stencil;
	SetDrawMode set_draw_mode;
	SetDrawOffset set_draw_offset;
	SetClipRect set_clip_rect;
	ClearClipRect clear_clip_rect;
	SetLineCapStyle set_line_cap_style;
	SetFont set_font;
	SetTextTracking set_text_tracking;
	PushContext push_context;
	PopContext pop_context;

	DrawBitmap draw_bitmap;
	TileBitmap tile_bitmap;
	DrawLine draw_line;
	FillTriangle fill_triangle;
	DrawRect draw_rect;
	FillRect fill_rect;
	DrawEllipse draw_ellipse;
	FillEllipse fill_ellipse;
	DrawScaledBitmap draw_scaled_bitmap;
	DrawText draw_text;

	NewBitmap new_bitmap;
	FreeBitmap free_bitmap;
	LoadBitmap load_bitmap;
	CopyBitmap copy_bitmap;
	LoadIntoBitmap load_into_bitmap;
	GetBitmapData get_bitmap_data;
	ClearBitmap clear_bitmap;
	RotatedBitmap rotated_bitmap;

	NewBitmapTable new_bitmap_table;
	FreeBitmapTable free_bitmap_table;
	LoadBitmapTable load_bitmap_table;
	LoadIntoBitmapTable load_into_bitmap_table;
	GetTableBitmap get_table_bitmap;

	LoadFont load_font;
	GetFontPage get_font_page;
	GetPageGlyph get_page_glyph;
	GetGlyphKerning get_glyph_kerning;
	GetTextWidth get_text_width;

	GetFrame get_frame;
	GetDisplayFrame get_display_frame;
	GetDebugBitmap get_debug_bitmap;
	CopyFrameBufferBitmap copy_frame_buffer_bitmap;
	MarkUpdatedRows mark_updated_rows;
	Display display;

	SetColorToPattern set_color_to_pattern;
	CheckMaskCollision check_mask_collision;
	SetScreenClipRect set_screen_clip_rect;
	FillPolygon fill_polygon;
	GetFontHeight get_font_height;

	GetDisplayBufferBitmap get_display_buffer_bitmap;
	DrawRotatedBitmap draw_rotated_bitmap;
	SetTextLeading set_text_leading;
	SetBitmapMask set_bitmap_mask;
	GetBitmapMask get_bitmap_mask;

	SetStencilImage set_stencil_image;
	MakeFontFromData make_font_from_data;
	GetTextTracking get_text_tracking;
	GetBitmapPixel get_bitmap_pixel;
	GetBitmapTableInfo get_bitmap_table_info;
	DrawTextInRect draw_text_in_rect;
}

def Clear = fn void(LCDColor color);
def SetBackgroundColor = fn void(LCDSolidColor color);
def SetStencil = fn void(LCDBitmap* stencil);
def SetDrawMode = fn LCDBitmapDrawMode(LCDBitmapDrawMode mode);
def SetDrawOffset = fn void(int dx, int dy);
def SetClipRect = fn void(int x, int y, int width, int height);
def ClearClipRect = fn void();
def SetLineCapStyle = fn void(LCDLineCapStyle endCapStyle);
def SetFont = fn void(LCDFont* font);
def SetTextTracking = fn void(int tracking);
def PushContext = fn void(LCDBitmap* target);
def PopContext = fn void();

def DrawBitmap = fn void(LCDBitmap* bitmap, int x, int y, LCDBitmapFlip flip);
def TileBitmap = fn void(LCDBitmap* bitmap, int x, int y, int width, int height, LCDBitmapFlip flip);
def DrawLine = fn void(int x1, int y1, int x2, int y2, int width, LCDColor color);
def FillTriangle = fn void(int x1, int y1, int x2, int y2, int x3, int y3, LCDColor color);
def DrawRect = fn void(int x, int y, int width, int height, LCDColor color);
def FillRect = fn void(int x, int y, int width, int height, LCDColor color);
def DrawEllipse = fn void(int x, int y, int width, int height, int lineWidth, float startAngle, float endAngle, LCDColor color);
def FillEllipse = fn void(int x, int y, int width, int height, float startAngle, float endAngle, LCDColor color);
def DrawScaledBitmap = fn void(LCDBitmap* bitmap, int x, int y, float xscale, float yscale);
def DrawText = fn int(void* text, usz len, PDStringEncoding encoding, int x, int y);

def NewBitmap = fn LCDBitmap*(int width, int height, LCDColor bgcolor);
def FreeBitmap = fn void(LCDBitmap* bitmap);
def LoadBitmap = fn LCDBitmap*(char* path, char** outerr);
def CopyBitmap = fn LCDBitmap*(LCDBitmap* bitmap);
def LoadIntoBitmap = fn void(char* path, LCDBitmap* bitmap, char** outerr);
def GetBitmapData = fn void(LCDBitmap* bitmap, int* width, int* height, int* rowbytes, char** mask, char** data);
def ClearBitmap = fn void(LCDBitmap* bitmap, LCDColor bgcolor);
def RotatedBitmap = fn LCDBitmap*(LCDBitmap* bitmap, float rotation, float xscale, float yscale, int* allocedSize);

def NewBitmapTable = fn LCDBitmapTable*(int count, int width, int height);
def FreeBitmapTable = fn void(LCDBitmapTable* table);
def LoadBitmapTable = fn LCDBitmapTable*(char* path, char** outerr);
def LoadIntoBitmapTable = fn void(char* path, LCDBitmapTable* table, char** outerr);
def GetTableBitmap = fn LCDBitmap*(LCDBitmapTable* table, int idx);

def LoadFont = fn LCDFont*(char* path, char** outErr);
def GetFontPage = fn LCDBitmap*(LCDFont* font, uint c);
def GetPageGlyph = fn LCDBitmap*(LCDFontPage* page, uint c, LCDBitmap** bitmap, int* advance);
def GetGlyphKerning = fn int(LCDFontGlyph* glyph, uint glyphcode, uint nextcode);
def GetTextWidth = fn int(LCDFont* font, void* text, usz len, PDStringEncoding encoding, int tracking);

def GetFrame = fn char*();
def GetDisplayFrame = fn char*();
def GetDebugBitmap = fn LCDBitmap*();
def CopyFrameBufferBitmap = fn LCDBitmap*();
def MarkUpdatedRows = fn void(int start, int end);
def Display = fn void();

def SetColorToPattern = fn void(LCDColor* color, LCDBitmap* bitmap, int x, int y);
def CheckMaskCollision = fn int(LCDBitmap* bitmap1, int x1, int y1, LCDBitmapFlip flip1, LCDBitmap* bitmap2, int x2, int y2, LCDBitmapFlip flip2, LCDRect rect);
def SetScreenClipRect = fn void(int x, int y, int width, int height);

def FillPolygon = fn void(int nPoints, int* coords, LCDColor color, LCDPolygonFillRule fillRule);
def GetFontHeight = fn int(LCDFont* font);
def GetDisplayBufferBitmap = fn LCDBitmap*();
def DrawRotatedBitmap = fn void(LCDBitmap* bitmap, int x, int y, float rotation, float centerx, float centery, float xscale, float yscale);
def SetTextLeading = fn void(int lineHeightAdjustment);

def SetBitmapMask = fn int(LCDBitmap* bitmap, LCDBitmap* mask);
def GetBitmapMask = fn LCDBitmap*(LCDBitmap* bitmap);
def SetStencilImage = fn void(LCDBitmap* stencil, int tile);
def MakeFontFromData = fn LCDFont*(LCDFontData* data, int wide);
def GetTextTracking = fn int();

def SetPixel = fn void(int x, int y, LCDColor c);
def GetBitmapPixel = fn LCDSolidColor(LCDBitmap* bitmap, int x, int y);
def GetBitmapTableInfo = fn void(LCDBitmapTable* table, int* count, int* width);
def DrawTextInRect = fn void(void* text, usz len, PDStringEncoding encoding, int x, int y, int width, int height, PDTextWrappingMode wrap, PDTextAlignment align);

