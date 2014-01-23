param($source, $fallback = "en")

$lines = Get-Content $source

$meta = $false

foreach ($line in $lines) {
	$line = $line.Trim()
	if ($line -eq [string]::Empty) { continue }
	if (!$meta) {
		if ($line -eq "---") {
			$meta = $true
		} else {
			break
		}
	} else {
		if ($line.StartsWith("lang:")) {
			return $line.Substring(5).Trim();
		}
		if ($line -eq "---" -or $line -eq "...") {
			break
		}
	}
}

return $fallback