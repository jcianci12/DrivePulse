# Define the path where the file will be created
$path = "G:\\COMMON\\networkfilebenchmark.txt"

# Define the path for the CSV file
$csvPath = "data.csv"

# Define the size of the file in bytes (4MB = 4*1024*1024 bytes)
$fileSize = 4 * 1024 * 1024

# Start an infinite loop
while ($true) {
    # Initialize the status and error message variables
    $status = $null
    $errorMessage = $null

    try {
        # Delete the file if it exists
        if (Test-Path $path) {
            Remove-Item $path
        }

        # Create a file with the specified size
        $fs = New-Object System.IO.FileStream $path, 'Create'
        
        # Generate a string of 'a' characters of the specified size
        $randomText = 'a' * $fileSize

        # Start the stopwatch for measuring the response time
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

        # Write the random text to the file
        $sw = New-Object System.IO.StreamWriter($fs)
        $sw.Write($randomText)
        $sw.Close()

        # Stop the stopwatch
        $stopwatch.Stop()

        # Calculate the response time
        $responseTime = $stopwatch.Elapsed.TotalSeconds

        # Set the status to "Success"
        $status = "1"

        Write-Host "File created at $path with size $fileSize bytes. Response time: $responseTime seconds."

        # Delete the file
        if (Test-Path $path) {
            Remove-Item $path
        }
    }
    catch {
        # Set the status to "Error" and store the error message
        $status = "0"
        $errorMessage = $_.Exception | Format-List -Force | Out-String
    
        # Escape the error message for CSV
        # $errorMessage = $errorMessage -replace '"', ''
        # $errorMessage = $errorMessage -replace ',', '""'
        
        Write-Host "An error occurred: $errorMessage"
    }
    
    # Export the data to the CSV file
    $csvData = New-Object PSObject -Property @{
        "Timestamp"    = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        "ResponseTime" = $responseTime
        "Status"       = $status
        "ErrorMessage" = "`"$errorMessage`"" # Enclose the escaped error message in double quotes
    }
    $csvData | Export-Csv -Path $csvPath -Append -NoTypeInformation
    

    # Wait for 5 seconds before the next iteration
    Start-Sleep -Seconds 10
}
