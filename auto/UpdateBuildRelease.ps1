$MyPath = [IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

pushd $MyPath
.\Update-Components.ps1
.\Update-Tools.ps1
.\Build-Project.ps1
.\Create-Release.ps1
popd