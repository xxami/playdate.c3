module playdate;

def SDFile = void;

enum FileOptions : int (int bit_state) {
	FILE_READ = 1<<0,
	FILE_READ_DATA = 1<<1,
	FILE_WRITE = 1<<2,
	FILE_APPEND = 2<<2
}

struct FileStat {
	int isdir;
	uint size;
	int m_year;
	int m_month;
	int m_day;
	int m_hour;
	int m_minute;
	int m_second;
}

const int SEEK_SET = 0;
const int SEEK_CUR = 1;
const int SEEK_END = 2;

struct PlaydateFile {
	ListFiles list_files;
	Stat stat;
	MkDir mk_dir;
	Unlink unlink;
	Rename rename;

	Open open;
	Close close;
	Read read;
	Write write;
	Flush flush;
	Tell tell;
	Seek seek;
}

def ListFilesCallback = fn void(char* path, void* userdata);
def ListFiles = fn int(char* path, ListFilesCallback cb, void* userdata, int showhidden);
def Stat = fn int(char* path, FileStat* stat);
def MkDir = fn int(char* path);
def Unlink = fn int(char* name, int recursive);
def Rename = fn int(char* from, char* to);

def Open = fn SDFile*(char* name, FileOptions mode);
def Close = fn int(SDFile* file);
def Read = fn int(SDFile* file, void* buf, uint len);
def Write = fn int(SDFile* file, void* buf, uint len);
def Flush = fn int(SDFile* file);
def Tell = fn int(SDFile* file);
def Seek = fn int(SDFile* file, int pos, int whence);

