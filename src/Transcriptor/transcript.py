#/bin/python
import contextlib
from io import SEEK_END
import math
import wave
from moviepy.editor import AudioFileClip
import speech_recognition as sr
import datetime
import os
import sys

def transcribe(video_path):
    temp_folder = "./temp/"
    transcribed_audio_file_name = "transcribed_speech.wav"
    audioclip = AudioFileClip(video_path)
    audioclip.write_audiofile(temp_folder + transcribed_audio_file_name)

    with contextlib.closing(wave.open(temp_folder + transcribed_audio_file_name, 'r')) as f:
        frames = f.getnframes()
        rate = f.getframerate()
        duration = frames / float(rate)
    total_duration = math.ceil(duration / 60)

    r = sr.Recognizer()

    f = open(video_path.rsplit('.', 1)[0] + " transcription.txt", "w")
    for i in range(0, total_duration):
        with sr.AudioFile(temp_folder + transcribed_audio_file_name) as source:
            audio = r.record(source, offset=i*60, duration=60)
        try:
            recognized_text = r.recognize_google(audio, language='pt-BR', show_all=True)
            # recognized_text = "TESTE!"
            print(recognized_text)
            f.write(f"[{datetime.timedelta(seconds=i*60)}] {recognized_text}\n")
            f.seek(0, os.SEEK_END)
        except:
            print("ERROR in transcribe!")

    f.close()

if __name__ == "__main__":
    if(len(sys.argv) > 1):
        transcribe(sys.argv[1])
