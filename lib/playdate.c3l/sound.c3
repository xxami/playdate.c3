module playdate;

import std::math;

const int AUDIO_FRAMES_PER_CYCLE = 512;

enum SoundFormat : int (int value) {
	SOUND_8BIT_MONO = 0,
	SOUND_8BIT_STEREO = 1,
	SOUND_16BIT_MONO = 2,
	SOUND_16BIT_STEREO = 3,
	SOUND_ADPCM_MONO = 4,
	SOUND_ADPCM_STEREO = 5
}


fn bool sound_format_is_stereo(SoundFormat f) {
	return (f.value & 1) != 0;
}

fn bool sound_format_is_16bit(SoundFormat f) {
	return f.value >= SoundFormat.SOUND_16BIT_MONO.value;
}

fn uint sound_format_bytes_per_frame(SoundFormat f) {
	return (sound_format_is_stereo(f) ? 2 : 1) * (sound_format_is_16bit(f) ? 2 : 1);
}

def MIDINote = float;
const MIDINote NOTE_C4 = 60f;

fn float pd_note_to_frequency(MIDINote n) {
	return 440 * math::pow(2.0f, (n-69)/12.0f);
}

fn MIDINote pd_frequency_to_note(float f) {
	return 12 * math::log2(f) - 36.376316562f;
}

distinct SoundSource = void;
def SndCallbackProc = fn void(SoundSource* c, void* userdata);

struct PlaydateSoundSource {
	SetVolume set_volume;
	GetVolume get_volume;
	IsPlaying is_playing;
	SetFinishCallback set_finish_callback;
}

def SetVolume = fn void(SoundSource* c, float lvol, float rvol);
def GetVolume = fn void(SoundSource* c, float* outl, float* outr);
def IsPlaying = fn int(SoundSource* c);
def SetFinishCallback = fn void(SoundSource* c, SndCallbackProc cb, void* userdata);

distinct FilePlayer = void;

struct PlaydateSoundFilePlayer {
	NewPlayer new_player;
	FreePlayerFP free_player;
	LoadIntoPlayer load_into_player;
	SetBufferLength set_buffer_length;
	Play play;
	IsPlayingFP is_playing;
	Pause pause;
	Stop stop;
	SetVolumeFP set_volume;
	GetVolumeFP get_volume;
	GetLength get_length;
	SetOffsetFP set_offset;
	SetRate set_rate;
	SetLoopRange set_loop_range;
	DidUnderRun did_underrun;
	SetFinishCallbackFP set_finish_callback;
	SetLoopCallback set_loop_callback;
	GetOffset get_offset;
	GetRate get_rate;
	SetStopOnUnderRun set_stop_on_underrun;
	FadeVolume fade_volume;
	SetMP3StreamSource set_mp3_stream_source;
}

def MP3SourceCallback = fn int(char* data, int bytes, void* userdata);

def NewPlayer = fn FilePlayer*();
def FreePlayerFP = fn void(FilePlayer* player);
def LoadIntoPlayer = fn int(FilePlayer* player, char* path);
def SetBufferLength = fn void(FilePlayer* player, float bufferLen);
def Play = fn int(FilePlayer* player, int repeat);
def IsPlayingFP = fn int(FilePlayer* player);
def Pause = fn void(FilePlayer* player);
def Stop = fn void(FilePlayer* player);
def SetVolumeFP = fn void(FilePlayer* player, float left, float right);
def GetVolumeFP = fn void(FilePlayer* player, float* left, float* right);
def GetLength = fn float(FilePlayer* player);
def SetOffsetFP = fn void(FilePlayer* player, float offset);
def SetRate = fn void(FilePlayer* player, float rate);
def SetLoopRange = fn void(FilePlayer* player, float start, float end);
def DidUnderRun = fn int(FilePlayer* player);
def SetFinishCallbackFP = fn void(FilePlayer* player, SndCallbackProc cb, void* userdata);
def SetLoopCallback = fn void(FilePlayer* player, SndCallbackProc cb, void* userdata);
def GetOffset = fn float(FilePlayer* player);
def GetRate = fn float(FilePlayer* player);
def SetStopOnUnderRun = fn void(FilePlayer* player, int flag);
def FadeVolume = fn void(FilePlayer* player, float left, float right, int len, SndCallbackProc cb, void* userdata);
def SetMP3StreamSource = fn void(FilePlayer* player, MP3SourceCallback cb, void* userdata, float bufferLen);

