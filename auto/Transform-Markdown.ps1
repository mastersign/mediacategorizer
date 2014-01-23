param (
	$source = $(throw "Argument source not specified."),
	$target = $(throw "Argument target not specified."),
	$options = @{}
)

$defOptions = @{
	figureTerm = "Abbildung"
	addFigureTerm = $true
}

$keys = $defOptions.Keys
foreach ($key in $keys) {
	if (!$options.ContainsKey($key)) {
		$options[$key] = $defOptions[$key]
	}
}

$figureNo = 0
$figures = @{}
$abbreviations = @{}

function register-figure($id) {
	if (!$script:figures.ContainsKey($id)) {
		$script:figureNo ++
		Write-Verbose "Registered Figure: $id -> $script:figureNo"
		$script:figures[$id] = $script:figureNo
	}
}

function figure-label($id) {
	$no = $script:figures[$id]
	if (!$no) { $no = "???" }
	Write-Verbose "Look-Up Figure $id -> $no"
	return $script:options.figureTerm + " " + $no
}

function step-figure-id() {
	begin {
		$pattern = "!\[#(?<id>[\w:-]+?)(\s+(?<alt>.*?))?\](?<ref>(\(.*?\)|\[.*?\])?)"
		$repl = "<a name=`"`${id}`"></a> ![`${alt}]`${ref}"

		$regexLine = [regex]"^$pattern`$"
		$replLine = "<a name=`"`${id}`"></a>`n`n![`${alt}]`${ref}"

		$regex = [regex]$pattern
	}
	process {
		$line = $_

		$match = $regexLine.Match($_)
		if ($match.Success) {
			$id = $match.Groups["id"].Value
			register-figure $id
			if ($script:options.addFigureTerm) {
				$label = (figure-label $id) + ": "
			} else {
				$label = ""
			}
			$replLine = "<a name=`"`${id}`"></a>`n`n![$label`${alt}]`${ref}"
			$line = $regexLine.Replace($line, $replLine)
		}

		$line = $regex.Replace($line, $repl)

		$line
	}
}

function step-figure-ref() {
	begin {
		$regex = [regex]"\[#(?<id>[\w:-]+?)(\s+(?<alt>.*?))?\]"
	}
	process {
		$line = $_
		$match = $regex.Match($line)
		while ($match.Success) {
			$id = $match.Groups["id"].Value
			Write-Verbose "Found Ref $id"
			$label = figure-label $id
			$repl = "[$label](#`${id})"
			$line = $regex.Replace($line, $repl, 1)
			$match = $regex.Match($line)
		}
		$line
	}
}

function step-find-abbreviations() {
	begin {
		$regex = [regex]"^\*\[(?<id>.*?)\]:\s*(?<text>.*)`$"
	}
	process {
		$match = $regex.Match($_)
		if ($match.Success) {
			$id = $match.Groups["id"].Value
			$text = $match.Groups["text"].Value
			Write-Verbose "Abbreviation ${id}: $text"
			$script:abbreviations[$id] = $text
		}
		$_
	}
}

function step-process-abbreviations() {
	begin {
		$defRegex = [regex]"^\*?\[(?<id>.*?)\]:\s*(?<text>.*)`$"
		$ex = ""
		foreach ($id in $script:abbreviations.Keys) {
			$excId = [regex]::Escape($id)
			if ($ex.Length -gt 0) {
				$ex += "|"
			}
			$ex += $excId
		}
		if (![string]::IsNullOrEmpty($ex)) {
			$regex = [regex]$ex
		} else {
			$regex = $null
		}
	}
	process {
		if ($regex -and !$defRegex.IsMatch($_)) {
			$matches = $regex.Matches($_)
			$diff = 0
			$result = $_
			foreach ($match in $matches) {
				if (!$match.Success) { continue }
				$id = $match.Value
				$text = $script:abbreviations[$id]
				$text = $text.Replace("`"", "&quot;").Replace("<", "&lt;").Replace(">", "&gt;")
				$repl = "<abbr title=`"$text`">$id</abbr>"
				$result = $result.Substring(0, $match.Index + $diff) + $repl + $_.Substring($match.Index + $match.Length)
				$diff += $repl.Length - $id.Length
			}
			$result
		} else {
			$_
		}
	}
}

$lines = Get-Content $source -Encoding utf8
$lines = $lines | step-figure-id
$lines = $lines | step-figure-ref
$lines = $lines | step-find-abbreviations
$lines = $lines | step-process-abbreviations
$lines | Out-File -FilePath $target -Encoding utf8
