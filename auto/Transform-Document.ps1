param (
	$source = $(throw "Argument source not specified."),
	$target = $(throw "Argument target not specified."),
	$formats = @("html", "docx", "latex", "pdf"),
	[switch]$keepIntermediate=$false
)

Write-Host "Transforming $source ..."

$myPath = [IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition);
$sourcePath = [IO.Path]::GetDirectoryName($source)

$intermediate = "${source}.tmp"
.\Transform-Markdown.ps1 $source $intermediate

if ($formats -contains "latex" -or $formats -contains "pdf") {
	$intermediateTeX = "${source}.tex.tmp"
		.\Transform-Markdown.ps1 $source $intermediateTeX `
		-options @{ addFigureTerm = $false }

	$langTeX = .\Translate-LatexLang.ps1 $(.\Read-Lang.ps1 $intermediate)
}

$templateHtml = [IO.Path]::Combine($myPath, "template.standalone.html");
$templateTeX = [IO.Path]::Combine($myPath, "template.tex");
$headerTeX = [IO.Path]::Combine($myPath, "header.tex");

$inputFormat = "markdown+pipe_tables+table_captions+pandoc_title_block+yaml_metadata_block+lists_without_preceding_blankline+abbreviations+tex_math_dollars+auto_identifiers+implicit_header_references"

pushd $sourcePath

if ($formats -contains "html") {
	pandoc -r $inputFormat `
		--default-image-extension=png `
		--normalize `
		--smart `
		-w html5 --toc --toc-depth=2 `
		--template $templateHtml `
		--filter pandoc-citeproc `
		--mathml `
		-o "$target.html" $intermediate
}

if ($formats -contains "docx") {
	pandoc -r $inputFormat `
		--default-image-extension=png `
		--normalize `
		--smart `
		-w docx --toc --toc-depth=2 `
		--filter pandoc-citeproc `
		-o "$target.docx" $intermediate
}

if ($formats -contains "rtf") {
	pandoc -r $inputFormat `
		--default-image-extension=png `
		--normalize `
		--smart `
		-w rtf `
		--filter pandoc-citeproc `
		-o "$target.rtf" $intermediate
}

if ($formats -contains "latex") {
	pandoc -f $inputFormat `
		--default-image-extension=png `
		--normalize `
		-w latex `
		--toc `
		--standalone `
		--filter pandoc-citeproc `
		--template=$templateTeX `
		--variable=documentclass:scrartcl `
		--variable=lang:$langTeX `
		-o "$target.tex" $intermediateTeX
}

if ($formats -contains "pdf") {
	pandoc -f $inputFormat `
		--normalize `
		--toc `
		--filter pandoc-citeproc `
		--latex-engine=xelatex `
		--template=$templateTeX `
		--variable=documentclass:scrartcl `
		--variable=lang:$langTeX `
		-o "$target.pdf" $intermediateTeX
}

del $intermediate
if ($intermediateTeX) { del $intermediateTeX }

popd