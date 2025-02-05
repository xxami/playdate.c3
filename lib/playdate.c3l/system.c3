module playdate;

def PDCallback = fn int(void* userdata);
def SetUpdateCallback = fn void(PDCallback update, void* userdata);

struct PlaydateSystem {
	SetUpdateCallback setUpdateCallback;
}
