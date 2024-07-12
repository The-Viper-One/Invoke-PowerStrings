# Invoke-PowerStrings

`Invoke-PowerStrings` is a PowerShell function that extracts readable strings from a file with specified encoding and minimum length. This can be particularly useful for analyzing binary files, logs, or any files where you need to extract text content.

## Parameters

- **`FilePath`** (Mandatory): The path to the file from which to extract strings.
- **`Encoding`** (Optional): The encoding to use for string extraction. Accepts `Default`, `Ascii`, or `Unicode`. Default is `Default`.
- **`MinimumLength`** (Optional): The minimum length of strings to extract. Default is 3.

## Usage

### Example 1: Extracting with Default Encoding and Minimum Length

```powershell
# Extracts strings with Ascii encoding and default minimum length of 3 from the specified file.
Invoke-PowerStrings -FilePath "\\Server.security.local\FilesShare\backup.bak" -Encoding Ascii

# Extracts strings with default encoding and minimum length of 5 from the specified file.
Invoke-PowerStrings -FilePath "C:\windows\temp\data.bin" -MinimumLength 5

# Execute with Unicode encoding and default minimum length of 3
Invoke-PowerStrings -FilePath "C:\windows\temp\data.bin" -Encoding Unicode -MinimumLength 3

