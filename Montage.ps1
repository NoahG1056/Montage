$Path=$PSScriptRoot
write-host "$Path"
write-host "What do you want"
write-host "1. crop the intro" 
write-host "2. change resolution videos" 
write-host "3. 9:16->16:9" 
$Choice=read-host
$Array=1..3
if ($Choice -in $Array){
	switch ( $Choice )
{
    1 { write-host "duration of the itro(Seconds)"
		$time=read-host
		New-Item -Path 'crop_videos' -ItemType Directory
		Get-ChildItem $Path -Filter *.mp4 | ForEach-Object { ffmpeg -i $_ -ss 00:00:$time -codec copy $Path\crop_videos\crop$_ }}
    2 { write-host "select resolution"
		write-host "1. 1280x720" 
		write-host "2. 1980x1080" 
		$resolution=read-host
		switch($resolution){
			1{New-Item -Path 'new_resolution_videos' -ItemType Directory
				Get-ChildItem $Path -Filter *.mp4 | ForEach-Object { ffmpeg -i $_ -s 1280x720 -c:a copy $Path\new_resolution_videos\resolution$_ }}
				
			2{New-Item -Path 'new_resolition_videos' -ItemType Directorys
				Get-ChildItem $Path -Filter *.mp4 | ForEach-Object { ffmpeg -i $_ -s 1980x1080 -c:a copy $Path\new_resolution_videos\resolution$_ }}}}
				
	3 {		New-Item -Path 'blur_videos' -ItemType Directory
			Get-ChildItem $Path -Filter *.mp4 | ForEach-Object {ffmpeg -i $_ -lavfi '[0:v]scale=ih*16/9:-1,boxblur=luma_radius=min(h\,w)/20:luma_power=1:chroma_radius=min(cw\,ch)/20:chroma_power=1[bg];[bg][0:v]overlay=(W-w)/2:(H-h)/2,crop=h=iw*9/16' -vb 800K $Path\blur_videos\blur$_}}}
}
else{
	write-host "Error, write correct choise"

}








