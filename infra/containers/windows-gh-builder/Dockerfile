# escape=`

# Use the latest Windows Server Core image with .NET Framework 4.8.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# Download the Build Tools bootstrapper.
ADD https://aka.ms/vs/16/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe

# Install Build Tools excluding workloads and components with known issues.
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
  --installPath C:\BuildTools `
  --all `
  --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 `
  --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 `
  --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 `
  --remove Microsoft.VisualStudio.Component.Windows81SDK `
  || IF "%ERRORLEVEL%"=="3010" EXIT 0

# Add the actions runner
RUN powershell.exe mkdir \actions-runner ;`
  cd \actions-runner ;`
  $progressPreference = 'silentlyContinue' ;`
  Invoke-WebRequest -Uri https://github.com/actions/runner/releases/download/v2.165.2/actions-runner-win-x64-2.165.2.zip -OutFile actions-runner-win-x64-2.165.2.zip ;`
  Add-Type -AssemblyName System.IO.Compression.FileSystem ;`
  [System.IO.Compression.ZipFile]::ExtractToDirectory("\"./actions-runner/actions-runner-win-x64-2.165.2.zip\"", "\"$PWD\"")

# Get ready to run
WORKDIR C:/actions-runner
ENV GH_TOKEN ""
ENV GH_URL ""
ENTRYPOINT .\config.cmd --unattended --url "%GH_URL%" --token "%GH_TOKEN%" && .\run.cmd
