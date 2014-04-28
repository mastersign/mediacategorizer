$MyPath = [IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

$BasePath = Resolve-Path "$MyPath\.."
$ComponentsPath = Resolve-Path "$BasePath\components"
$DocsPath = Resolve-Path "$BasePath\docs"
$TargetDir = "$BasePath\release"
if (Test-Path $TargetDir) { Remove-Item $TargetDir -Recurse -Force }
if (!(Test-Path $TargetDir)) { mkdir $TargetDir | Out-Null }

function get-clojure-project-name($projectDir) {
	$prjFile = Resolve-Path "$projectDir\project.clj"
	[string]$prjConfig = Get-Content $prjFile
	$regex = [regex]"\(defproject[\s,;]+(?<name>.*?)[\s,;]+`"(?<version>.*?)`""
	$match = $regex.Match($prjConfig)
	if ($match.Success) {
		return $match.Groups["name"].Value + "-" + $match.Groups["version"].Value
	} else {
		return $null
	}
}

$SourceToolsDir = "$BasePath\tools"
$TargetToolsDir = "$TargetDir\tools"
mkdir $TargetToolsDir | Out-Null

Copy-Item "$SourceToolsDir\FFmpeg" "$TargetToolsDir\FFmpeg" -Recurse
Copy-Item "$SourceToolsDir\WaveViz" "$TargetToolsDir\WaveViz" -Recurse

$distilleryProjectName = get-clojure-project-name "$ComponentsPath\Distillery"
if ($distilleryProjectName) {
    Copy-Item "$ComponentsPath\Distillery\target\${distilleryProjectName}-standalone.jar" "$TargetToolsDir\distillery.jar"
} else {
    Write-Error "Could not determine version of distillery project."
    return
}

$SourceTranscripterDir = "$ComponentsPath\Transcripter"
$TargetTranscripterDir = "$TargetToolsDir\Transcripter"
mkdir $TargetTranscripterDir | Out-Null
Copy-Item "$SourceTranscripterDir\bin\Release\Transcripter.exe*" $TargetTranscripterDir

$SourceMCDir = "$ComponentsPath\MediaCategorizer"
Copy-Item "$SourceMCDir\bin\Release\MediaCategorizer.exe*" $TargetDir
Copy-Item "$SourceMCDir\lib\*" $TargetDir

$SourceDocsDir = "$DocsPath\out"
$TargetDocsDir = "$TargetDir\docs"
if (Test-Path $SourceDocsDir) {
	mkdir $TargetDocsDir | Out-Null
	Get-ChildItem $SourceDocsDir -Directory | % { Copy-Item $_.FullName $TargetDocsDir -Recurse }
	Copy-Item "$SourceDocsDir\*.html" $TargetDocsDir
}