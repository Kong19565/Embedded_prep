#====================================================================
# Script to compile Lab 3 HTML Report to PDF with your real screenshots
#====================================================================

$ReportDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$HtmlFile = Join-Path $ReportDir "Report_Lab3_Proteus_AVR.html"
$ImgDir = Join-Path $ReportDir "report_img"
$PdfFile = Join-Path $ReportDir "Report_Lab3_Proteus_AVR.pdf"

$TempHtml = "C:\Users\kong\AppData\Local\Temp\Report_Lab3_Proteus_AVR.html"
$TempPdf = "C:\Users\kong\AppData\Local\Temp\Report_Lab3_Proteus_AVR.pdf"
$TempImg = "C:\Users\kong\AppData\Local\Temp\report_img"

Write-Host "Checking required files..."
if (-not (Test-Path $HtmlFile)) {
    Write-Error "HTML report file not found: $HtmlFile"
    Pause
    exit 1
}

# 1. Copy files to Temp to handle spaces and relative paths
Write-Host "Copying files to Temp folder..."
Copy-Item -Path $HtmlFile -Destination $TempHtml -Force
if (Test-Path $ImgDir) {
    Copy-Item -Path $ImgDir -Destination $TempImg -Recurse -Force
}

# 2. Run Google Chrome to print HTML to PDF
Write-Host "Compiling HTML to PDF using Chrome..."
$ChromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
if (-not (Test-Path $ChromePath)) {
    Write-Error "Google Chrome was not found at $ChromePath"
    Pause
    exit 1
}

$Arguments = @(
    "--headless",
    "--disable-gpu",
    "--no-sandbox",
    "--allow-file-access-from-files",
    "--no-pdf-header-footer",
    "--print-to-pdf=$TempPdf",
    $TempHtml
)

Start-Process -FilePath $ChromePath -ArgumentList $Arguments -Wait -NoNewWindow

# 3. Copy PDF back and Clean up
if (Test-Path $TempPdf) {
    Write-Host "PDF compiled successfully. Copying back to project folder..."
    # Attempt to copy, handle locks
    try {
        Copy-Item -Path $TempPdf -Destination $PdfFile -Force
        Write-Host "Report compiled successfully to: $PdfFile"
    } catch {
        Write-Warning "Could not overwrite $PdfFile (likely open and locked in reader)."
        $AlternativePdf = Join-Path $ReportDir "Report_Lab3_Proteus_AVR_updated.pdf"
        Copy-Item -Path $TempPdf -Destination $AlternativePdf -Force
        Write-Host "Saved compiled report to: $AlternativePdf"
    }
} else {
    Write-Error "PDF compilation failed."
}

# Clean up Temp folder
Write-Host "Cleaning up temp files..."
Remove-Item -Path $TempHtml -Force -ErrorAction SilentlyContinue
Remove-Item -Path $TempPdf -Force -ErrorAction SilentlyContinue
if (Test-Path $TempImg) {
    Remove-Item -Path $TempImg -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "Done!"
Pause
