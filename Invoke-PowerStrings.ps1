    <#
    .SYNOPSIS
    Extracts readable strings from a specified file using the chosen encoding and minimum length.

    .DESCRIPTION
    The `Invoke-PowerStrings` function reads the content of a specified file and extracts readable strings 
    based on the given encoding and minimum length. It supports 'Default', 'Ascii', and 'Unicode' encodings. 
    The function is useful for extracting text from binary files, logs, and other data files.

    .PARAMETER FilePath
    The path to the file from which to extract strings. This parameter is mandatory and must be a valid file path.

    .PARAMETER Encoding
    The encoding to use for string extraction. Accepts 'Default', 'Ascii', or 'Unicode'. Default is 'Default'.

    .PARAMETER MinimumLength
    The minimum length of strings to extract. Default is 3.

    .EXAMPLE
    Extract-Strings -FilePath "\\Server.security.local\FilesShare\backup.bak" -Encoding Ascii
    Extracts strings with Ascii encoding and default minimum length of 3 from the specified file.

    .EXAMPLE
    Extract-Strings -FilePath "C:\windows\temp\data.bin
    Extracts strings with default encoding and minimum length of 3 from the specified file.
    #>    


function Invoke-PowerStrings {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateScript({ Test-Path $_ -PathType 'Leaf' })]
        [string]$FilePath,

        [ValidateSet('Default', 'Ascii', 'Unicode')]
        [string]$Encoding = 'Default',

        [uint32]$MinimumLength = 3
    )

    $Results = @()

    if ($Encoding -eq 'Unicode' -or $Encoding -eq 'Default') {
        $UnicodeFileContents = [System.IO.File]::ReadAllText($FilePath, [System.Text.Encoding]::Unicode)
        $UnicodeRegex = "[\u0020-\u007E]{$MinimumLength,}"
        $Results += [regex]::Matches($UnicodeFileContents, $UnicodeRegex) | ForEach-Object { $_.Value }
    }

    if ($Encoding -eq 'Ascii' -or $Encoding -eq 'Default') {
        $AsciiFileContents = [System.IO.File]::ReadAllBytes($FilePath)
        $AsciiString = -join ($AsciiFileContents | ForEach-Object { [char]$_ })
        $AsciiRegex = "[\x20-\x7E]{$MinimumLength,}"
        $Results += [regex]::Matches($AsciiString, $AsciiRegex) | ForEach-Object { $_.Value }
    }

    $Results | ForEach-Object { Write-Output $_ }
}
