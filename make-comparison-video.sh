cd $1

# for each model AMT, FILM, GMFSS, IFRNet, IFUNet, M2M, RIFE
for model in AMT FILM GMFSS IFRNet IFUNet M2M RIFE 
do 
	echo "Creating video for $model"
	../convert-to-mp4.sh $model
done

../convert-to-mp4.sh original

echo "Now joining videos in a grid"

ffmpeg \
-i AMT.mp4 \
-i FILM.mp4 \
-i GMFSS.mp4 \
-i IFRNet.mp4 \
-i IFUNet.mp4 \
-i M2M.mp4 \
-i RIFE.mp4 \
-i original.mp4 \
-filter_complex " \
[0:v][1:v][2:v]hstack=inputs=3[top]; \
[3:v][4:v][5:v]hstack=inputs=3[middle]; \
[7:v]setpts=4*PTS,pad=iw*2:ih[original]; \
[6:v][original]hstack=inputs=2[bottom]; \
[top][middle][bottom]vstack=inputs=3[v]; \
[v]drawtext=text='$1':x=main_w-text_w-100:y=main_h-text_h-100:fontsize=64:fontcolor=white[v2]
" \
-map "[v2]" -c:a none "../$1.mp4"

