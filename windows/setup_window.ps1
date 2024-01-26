# Tutorial: https://youtu.be/CRouVhWoWMA
# Run this command if no execution policy error: Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Util function
function Write-Start {
    param($msg)
    Write-Host (">> "+$msg) -ForegroundColor Green
}

function Write-Done { Write-Host "DONE" -ForegroundColor Blue; Write-Host }

# Start
Start-Process -Wait powershell -verb runas -ArgumentList "Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0"

Write-Start -msg "Installing Scoop..."
if (Get-Command scoop -errorAction SilentlyContinue)
{
    Write-Warning "Scoop already installed"
}
else {
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    irm get.scoop.sh | iex
}
Write-Done

Write-Start -msg "Initializing Scoop..."
    scoop install git
    scoop bucket add extras
    scoop bucket add nerd-fonts
    scoop bucket add java
    scoop update
Write-Done

Write-Start -msg "Installing Scoop's packages"
    scoop install <#Web browser #> firefox brave googlechrome
    scoop install <# Tool #> alacritty neofetch obs-studio which ripgrep
    scoop install <# Coding #> neovim vscode gcc nodejs openjdk python postman
    scoop install <# Runtime lib #> vagrant
    Start-Process -Wait powershell -verb runas -ArgumentList "scoop install DejaVuSanMono-NF-Mono vcredist-aio nonportable/virtualbox-np docker"
Write-Done

Write-Start -msg "Configuring alacritty"
    $DestinationPath = "~\AppData\Roaming\alacritty"
    If (-not (Test-Path $DestinationPath)) {
        New-Item -ItemType Directory -Path $DestinationPath -Force
    }
    Copy-Item ".\terminals\.config\alacritty\alacritty.yml" -Destination $DestinationPath -Force
Write-Done

Write-Start -msg "Configuring vim"
    $DestinationPath = "~\AppData\Local\nvim"
    If (-not (Test-Path $DestinationPath)) {
        New-Item -ItemType Directory -Path $DestinationPath -Force
    }
    Copy-Item ".\neovim\.config\nvim\*" -Destination $DestinationPath -Force
    iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |` ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
    nvim -E -s -u "$($env:LOCALAPPDATA)\nvim\init.vim" +PlugInstall +PlugUpdate +q
Write-Done

Write-Start -msg "Configuring VSCode"
    code --install-extension vscodevim.vim --force # force to update latest version, or using @version eg: vscodevim.vim@1.2.3
    code --install-extension ritwickdey.LiveServer --force 
Write-Done

Write-Start -msg "Enable Virtualization"
Start-Process -Wait powershell -verb runas -ArgumentList @"
    echo y | Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -Norestart
    echo y | Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -Norestart
    echo y | Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All
    echo y | Enable-WindowsOptionalFeature -Online -FeatureName Containers -All
"@
Write-Done

Write-Start -msg "Installing WSL..."
If(!(wsl -l -v)) {
    wsl --install
    wsl --update
    wsl --install --no-launch --web-downlad -d Ubuntu
}
Else {
    Write-Warning "WSL installed"
}
Write-Done