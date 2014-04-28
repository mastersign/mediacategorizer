$MyPath = [IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

$BasePath = Resolve-Path "$MyPath\.."
$ComponentsPath = Resolve-Path "$BasePath\components"

function build-vs-solution($solutionFile) {
	$msbuild = "${env:SystemRoot}\Microsoft.NET\Framework\v4.0.30319\msbuild.exe"
	& $msbuild /p:Configuration=Release /verbosity:minimal $solutionFile
}

function run-cmd($cmd, $arg) {
	cmd /C "call `"$cmd`" $arg"
}

pushd "$ComponentsPath\Distillery"
run-cmd "lein.bat" "self-install"
run-cmd "$ComponentsPath\Distillery\build-jar.bat"
popd

build-vs-solution "$ComponentsPath\Transcripter\Transcripter.sln"
build-vs-solution "$ComponentsPath\MediaCategorizer\MediaCategorizer.sln"
