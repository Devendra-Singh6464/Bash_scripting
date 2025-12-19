import pytube

try:
    link = input('Enter the YouTube Video URL: ')
    video_download = pytube.YouTube(link)
    video_download.streams.get_highest_resolution().download()
    print('Video Downloaded:', link)
except Exception as e:
    print('Error:', e)

