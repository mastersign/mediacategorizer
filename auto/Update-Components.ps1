$MyPath = [IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

$BasePath = Resolve-Path "$MyPath\.."
$ComponentsPath = "$BasePath\components"
if (!(Test-Path $ComponentsPath)) {
	mkdir $ComponentsPath | Out-Null
}
$BaseRepo = "https://github.com/mastersign/mediacategorizer"

function check-git() {
    try {
        $version = $(git --version)
        return $version.StartsWith("git")
    } catch {
        return $false
    }
}

function current-branch($dir) {
  pushd $dir
  $status = git status
  popd
  $regex = [regex]"On branch (.+?)\s"
  $match = $regex.Match($status)
  if ($match.Success) {
    return $match.Groups[1].Value
  } else {
    return $null
  }
}

function update-working-copy($repo, $dir, $branch) {
    if (Test-Path $dir) {
        pushd $dir
        git checkout $branch
        git pull --commit --ff
        popd
    } else {
        git clone $repo $dir
        git checkout $branch
    }
}

if (-not (check-git)) {
    Write-Error "git not found"
    return
}

$Branch = current-branch $BasePath
if (-not $Branch) {
  Write-Error "could not determine current branch"
}

$UiPath = "$ComponentsPath\MediaCategorizer"
$TranscripterPath = "$ComponentsPath\Transcripter"
$DistilleryPath = "$ComponentsPath\Distillery"

$UiRepo = $BaseRepo + "-ui.git"
$TranscripterRepo = $BaseRepo + "-transcripter.git"
$DistilleryRepo = $BaseRepo + "-distillery.git"

update-working-copy $UiRepo $UiPath $Branch
update-working-copy $TranscripterRepo $TranscripterPath $Branch
update-working-copy $DistilleryRepo $DistilleryPath $Branch
