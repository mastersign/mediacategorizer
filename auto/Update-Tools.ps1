$MyPath = [IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

$BasePath = Resolve-Path "$MyPath\.."
$BasePath = "$BasePath\tools"
if (!(Test-Path $BasePath)) {
	mkdir $BasePath | Out-Null
}

$7zipUrl = "https://sourceforge.net/projects/sevenzip/files/7-Zip/9.20/7za920.zip/download"
$7zipDir = "$BasePath\7z"

$ffmpegUrl = "http://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-latest-win32-static.7z"
$ffmpegDir = "$BasePath\FFmpeg"

$wavevizUrl = "https://github.com/mastersign/waveviz/releases/download/v1.1.0/WaveViz.exe"
$wavevizDir = "$BasePath\WaveViz"


function unzip($filePath, $targetDir) {
    if (!(Test-Path $targetDir)) { mkdir $targetDir | Out-Null }
    $shellApp = New-Object -com shell.application
    $zipFile = $shellApp.namespace($filePath)
    $dest = $shellApp.namespace($targetDir)
    $dest.Copyhere($zipFile.items(), 0x10)
}

function un7zip($filePath, $targetDir) {
    & "$script:7zipDir\7za.exe" x "-o$targetDir" $filePath
}

function download($url, $targetFile) {
    if (Test-Path $targetFile) {
        Remove-Item $targetFile
    }
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($url, $targetFile)
}

## Download 7zip

if (!(Test-Path "$7zipDir\7za.exe")) {
	$tmp = "$BasePath\download.zip"
	download $7zipUrl $tmp
	unzip $tmp $7zipDir
	Remove-Item $tmp
}

## Download FFmpeg

if (!(Test-Path "$ffmpegDir\bin\ffmpeg.exe")) {
	$tmp = "$BasePath\download.7z"
	download $ffmpegUrl $tmp
	un7zip $tmp $BasePath
	Remove-Item $tmp
	if (Test-Path $ffmpegDir) { Remove-Item $ffmpegDir -Recurse -Force }
	Get-ChildItem "$BasePath\ffmpeg-*-win32-static" -Directory `
		| % { Move-Item $_ $ffmpegDir }
}
if (Test-Path "$ffmpegDir\bin\ffplay.exe") { Remove-Item "$ffmpegDir\bin\ffplay.exe" }
if (Test-Path "$ffmpegDir\ff-prompt.bat") { Remove-Item "$ffmpegDir\ff-prompt.bat" }
if (Test-Path "$ffmpegDir\doc") { Remove-Item "$ffmpegDir\doc" -Recurse -Force }
if (Test-Path "$ffmpegDir\presets") { Remove-Item "$ffmpegDir\presets" -Recurse -Force }

## Download WaveViz

if (!(Test-Path "$wavevizDir\WaveViz.exe")) {
	if (!(Test-Path $wavevizDir)) { mkdir $wavevizDir | Out-Null }
	download $wavevizUrl "$wavevizDir\WaveViz.exe"
}
