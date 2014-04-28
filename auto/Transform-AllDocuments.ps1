param (
	$sourceDir = "..\docs",
	$targetDir = "..\docs\out",
	$formats = @("html", "docx")
)

if (!(Test-Path $targetDir)) {
  mkdir $targetDir | Out-Null
}

[string]$sourceDir = Resolve-Path $sourceDir
[string]$targetDir = Resolve-Path $targetDir

$myPath = [IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition);

if ($sourceDir -ne $targetDir) {
	foreach ($d in (gci $sourceDir -Directory)) {
		$name = [IO.Path]::GetFileName($d)
		$path = $d.FullName
		if (!$name.StartsWith(".") -and ($targetDir -ne $path)) {
			cp $path $targetDir -Recurse -Force
		}
	}
}

function transform($source) {
	$ext = [IO.Path]::GetExtension($source)
	if ($ext -eq ".md") {
		$target = [IO.Path]::Combine($script:targetDir, [IO.Path]::GetFileNameWithoutExtension($source))
		& "$myPath\Transform-Document.ps1" -source $source -target $target -formats $formats
	}
}

foreach ($f in (gci $sourceDir -File)) {
  transform $f.FullName
}
