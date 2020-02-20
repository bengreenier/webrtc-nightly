$scriptPath = Split-Path -Parent $PSCommandPath
$rootDir = Join-Path $scriptPath ../
$toolsDir = Join-Path $rootDir depot_tools
$progressPreference = 'silentlyContinue'

Write-Output "Script Path: $scriptPath"
Write-Output "   Root Dir: $rootDir"
Write-Output "  Tools Dir: $toolsDir"

# Download depot_tools
# From https://chromium.googlesource.com/chromium/src/+/master/docs/windows_build_instructions.md
Invoke-WebRequest -Method GET -Uri https://storage.googleapis.com/chrome-infra/depot_tools.zip -OutFile $scriptPath\depot_tools.zip
Expand-Archive -Path $scriptPath\depot_tools.zip -DestinationPath $rootDir\depot_tools -Force

# Add them to path
$initPath = $env:Path
$env:Path += ";$toolsDir"
Write-Output "PATH: $env:Path"

# Sync gclient (using local toolchain)
$env:DEPOT_TOOLS_WIN_TOOLCHAIN = "0"
Start-Process -WorkingDirectory $rootDir -FilePath $toolsDir\gclient.bat -ArgumentList  "sync" -NoNewWindow -Wait

# Generate build files
Start-Process -WorkingDirectory $rootDir\src -FilePath $toolsDir\gn.bat -ArgumentList  "gen", "out/Default" -NoNewWindow -Wait

# Run the build (with summary enabled)
$env:NINJA_SUMMARIZE_BUILD = "1"
Start-Process -WorkingDirectory $rootDir\src -FilePath $toolsDir\autoninja.bat -ArgumentList  "-C", "out/Default" -NoNewWindow -Wait

# Remove additions to path
$env:Path = $initPath