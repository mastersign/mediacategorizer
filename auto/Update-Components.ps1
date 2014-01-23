$MyPath = [IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

$BasePath = Resolve-Path "$MyPath\.."
$BaseRepo = "https://github.com/mastersign/mediacategorizer"

function check-git() {
    try {
        $version = $(git --version)
        return $version.StartsWith("git")
    } catch {
        return $false
    }
}

function update-working-copy($repo, $dir) {
    if (Test-Path $dir) {
        pushd $dir
        git pull --commit --ff
        popd
    } else {
        git clone $repo $dir
    }
}

if (-not (check-git)) {
    Write-Error "git not found"
    return
}

$UiPath = "$BasePath\MediaCategorizer"
$TranscripterPath = "$BasePath\Transcripter"
$DistilleryPath = "$BasePath\Distillery"

$UiRepo = $BaseRepo + "-ui.git"
$TranscripterRepo = $BaseRepo + "-transcripter.git"
$DistilleryRepo = $BaseRepo + "-distillery.git"

update-working-copy $UiRepo $UiPath
update-working-copy $TranscripterRepo $TranscripterPath
update-working-copy $DistilleryRepo $DistilleryPath
