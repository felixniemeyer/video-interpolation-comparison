VFI_MODEL=$1

ffmpeg -pattern_type glob -i "$VFI_MODEL*.png" -vf "drawtext=text='$VFI_MODEL':fontsize=128:fontcolor=white:x=100:y=400" -c:a none $VFI_MODEL.mp4
