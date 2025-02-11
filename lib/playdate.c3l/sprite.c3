module playdate;

enum SpriteCollisionResponseType : int {
	COLLISIONTYPE_SLIDE,
	COLLISIONTYPE_FREEZE,
	COLLISIONTYPE_OVERLAP,
	COLLISIONTYPE_BOUNCE
}

struct PDRect {
	float x;
	float y;
	float width;
	float height;
}

fn PDRect pd_make_rect(float x, float y, float width, float height) {
	PDRect r = { .x = x, .y = y, .width = width, .height = height };
	return r;
}

struct CollisionPoint {
	float x;
	float y;
}

struct CollisionVector {
	int x;
	int y;
}

distinct LCDSprite = void;
distinct CWCollisionInfo = void;
distinct CWItemInfo = void;

struct SpriteCollisionInfo {
	LCDSprite* sprite;
	LCDSprite* other;
	SpriteCollisionResponseType response_type;
	char overlaps;
	float ti;
	CollisionPoint move;
	CollisionVector normal;
	CollisionPoint touch;
	PDRect sprite_rect;
	PDRect other_rect;
}

struct SpriteQueryInfo {
	LCDSprite* sprite;
	float ti1;
	float ti2;
	CollisionPoint entry_point;
	CollisionPoint exit_point;
}

def LCDSpriteDrawFunction = fn void(LCDSprite* sprite, PDRect bounds, PDRect drawrect);
def LCDSpriteUpdateFunction = fn void(LCDSprite* sprite);
def LCDSpriteCollisionFilterProc = fn SpriteCollisionResponseType(LCDSprite* sprite, LCDSprite *other);

struct PlaydateSprite {
	SetAlwaysRedraw set_always_redraw;
	AddDirtyRect add_dirty_rect;
	DrawSprites draw_sprites;
	UpdateAndDrawSprites update_and_draw_sprites;

	NewSprite new_sprite;
	FreeSprite free_sprite;
	Copy copy;

	AddSprite add_sprite;
	RemoveSprite remove_sprite;
	RemoveSprites remove_sprites;
	RemoveAllSprites remove_all_sprites;
	GetSpriteCount get_sprite_count;

	SetBounds set_bounds;
	GetBounds get_bounds;
	MoveTo move_to;
	MoveBy move_by;

	SetImage set_image;
	GetImage get_image;
	SetSize set_size;
	SetZIndex set_z_index;
	GetZIndex get_z_index;

	SetDrawModePS set_draw_mode;
	SetImageFlip set_image_flip;
	GetImageFlip get_image_flip;
	SetStencilPS set_stencil;

	SetClipRectPS set_clip_rect;
	ClearClipRectPS clear_clip_rect;
	SetClipRectsInRange set_clip_rects_in_range;
	ClearClipRectsInRange clear_clip_rects_in_range;

	SetUpdatesEnabled set_updates_enabled;
	UpdatesEnabled updates_enabled;
	SetCollisionsEnabled set_collisions_enabled;
	CollisionsEnabled collisions_enabled;
	SetVisible set_visible;
	IsVisible is_visible;
	SetOpaque set_opaque;
	MarkDirty mark_dirty;

	SetTag set_tag;
	GetTag get_tag;

	SetIgnoresDrawOffset set_ignores_draw_offset;

	SetUpdateFunction set_update_function;
	SetDrawFunction set_draw_function;

	GetPosition get_position;

	ResetCollisionWorld reset_collision_world;

	SetCollideRect set_collide_rect;
	GetCollideRect get_collide_rect;
	ClearCollideRect clear_collide_rect;

	SetCollisionResponseFunction set_collision_response_function;
	CheckCollisions check_collisions;
	MoveWithCollisions move_with_collisions;
	QuerySpritesAtPoint query_sprites_at_point;
	QuerySpritesInRect query_sprites_in_rect;
	QuerySpritesAlongLine query_sprites_along_line;
	QuerySpriteInfoAlongLine query_sprite_info_along_line;
	OverlappingSprites overlapping_sprites;
	AllOverlappingSprites all_overlapping_sprites;

	SetStencilPattern set_stencil_pattern;
	ClearStencil clear_stencil;
	SetUserdata set_userdata;
	GetUserdata get_userdata;
	SetStencilImagePS set_stencil_image;
	SetCenter set_center;
	GetCenter get_center;
}

def SetAlwaysRedraw = fn void(int flag);
def AddDirtyRect = fn void(LCDRect dirtyRect);
def DrawSprites = fn void();
def UpdateAndDrawSprites = fn void();

def NewSprite = fn LCDSprite*();
def FreeSprite = fn void(LCDSprite* sprite);
def Copy = fn LCDSprite*(LCDSprite* sprite);

def AddSprite = fn void(LCDSprite* sprite);
def RemoveSprite = fn void(LCDSprite* sprite);
def RemoveSprites = fn void(LCDSprite** sprites, int count);
def RemoveAllSprites = fn void();
def GetSpriteCount = fn int();

def SetBounds = fn void(LCDSprite* sprite, PDRect bounds);
def GetBounds = fn PDRect(LCDSprite* sprite);
def MoveTo = fn void(LCDSprite* sprite, float x, float y);
def MoveBy = fn void(LCDSprite* sprite, float dx, float dy);

def SetImage = fn void(LCDSprite* sprite, LCDBitmap* image, LCDBitmapFlip flip);
def GetImage = fn LCDBitmap*(LCDSprite* sprite);
def SetSize = fn void(LCDSprite* s, float width, float height);
def SetZIndex = fn void(LCDSprite* sprite, short zIndex);
def GetZIndex = fn short(LCDSprite* sprite);

def SetDrawModePS = fn void(LCDSprite* sprite, LCDBitmapDrawMode mode);
def SetImageFlip = fn void(LCDSprite* sprite, LCDBitmapFlip flip);
def GetImageFlip = fn LCDBitmapFlip(LCDSprite* sprite);
def SetStencilPS = fn void(LCDSprite* sprite, LCDBitmap* stencil);

def SetClipRectPS = fn void(LCDSprite* sprite, LCDRect clipRect);
def ClearClipRectPS = fn void(LCDSprite* sprite);
def SetClipRectsInRange = fn void(LCDRect clipRect, int startZ, int endZ);
def ClearClipRectsInRange = fn void(int startZ, int endZ);

def SetUpdatesEnabled = fn void(LCDSprite* sprite, int flag);
def UpdatesEnabled = fn int(LCDSprite* sprite);
def SetCollisionsEnabled = fn void(LCDSprite* sprite, int flag);
def CollisionsEnabled = fn int(LCDSprite* sprite);
def SetVisible = fn void(LCDSprite* sprite, int flag);
def IsVisible = fn int(LCDSprite* sprite);
def SetOpaque = fn void(LCDSprite* sprite, int flag);
def MarkDirty = fn void(LCDSprite* sprite);

def SetTag = fn void(LCDSprite* sprite, short tag);
def GetTag = fn char(LCDSprite* sprite);

def SetIgnoresDrawOffset = fn void(LCDSprite* sprite, int flag);

def SetUpdateFunction = fn void(LCDSprite* sprite, LCDSpriteUpdateFunction func);
def SetDrawFunction = fn void(LCDSprite* sprite, LCDSpriteDrawFunction func);

def GetPosition = fn void(LCDSprite* sprite, float* x, float* y);

def ResetCollisionWorld = fn void();

def SetCollideRect = fn void(LCDSprite* sprite, PDRect collideRect);
def GetCollideRect = fn PDRect(LCDSprite* sprite);
def ClearCollideRect = fn void(LCDSprite* sprite);

def SetCollisionResponseFunction = fn void(LCDSprite* sprite, LCDSpriteCollisionFilterProc func);
def CheckCollisions = fn SpriteCollisionInfo*(LCDSprite* sprite, float goalX, float goalY, float* actualX, float* actualY, int* len);
def MoveWithCollisions = fn SpriteCollisionInfo*(LCDSprite* sprite, float goalX, float goalY, float* actualX, float* actualY, int* len);
def QuerySpritesAtPoint = fn LCDSprite**(float x, float y, int* len);
def QuerySpritesInRect = fn LCDSprite**(float x, float y, float width, float height, int* len);
def QuerySpritesAlongLine = fn LCDSprite**(float x1, float y1, float x2, float y2, int* len);
def QuerySpriteInfoAlongLine = fn SpriteQueryInfo*(float x1, float y1, float x2, float y2, int* len);
def OverlappingSprites = fn LCDSprite**(LCDSprite* sprite, int* len);
def AllOverlappingSprites = fn LCDSprite**(int* len);

def SetStencilPattern = fn void(LCDSprite* sprite, char[8] pattern);
def ClearStencil = fn void(LCDSprite* sprite);
def SetUserdata = fn void(LCDSprite* sprite, void* userdata);
def GetUserdata = fn void*(LCDSprite* sprite);
def SetStencilImagePS = fn void(LCDSprite* sprite, LCDBitmap* stencil, int tile);
def SetCenter = fn void(LCDSprite* s, float x, float y);
def GetCenter = fn void(LCDSprite* s, float* x, float* y);
