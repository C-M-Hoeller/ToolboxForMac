#!/bin/sh
#----------------------------Global Variables-----------------------------------
declare -a ShellTools=("tldr" "mc" "fd" "ripgrep" "fzf" "tree") 
# Cask Formulae
declare -a OfficeFormulae=("typora" "slite" "clickup" "ticktick" "airtable")
declare -a CloudFormulae=("nextcloud")
declare -a MessengerFormulae=("whatsapp" "discord" "biscuit")
declare -a MediaFormulae=("spotify" "vlc")
declare -a DesignFormulae=("figma")
declare -a DeveloperFormulae=("visual-studio-code" "jetbrains-toolbox" "github" "postman" "teamviewer" "iterm2" "parallels" "docker" "wireshark" "coderunner")
declare -a BrowserFormulae=("google-chrome" "firefox" "cleanmymac")
declare -a UtilitiesFormulae=("numi" "oversight" "rocket" "hiddenbar" "monitorcontrol")
declare -a ExtraFormulae=("fork" "setapp" "visual-studio" "calibre" "unetbootin" "drawio" "responsively" "azure-data-studio" "filezilla" "logitech-options" "itsycal" "endpoint_security_vpn" "xtrafinder" "divvy")

#---------------------------Helper Functions------------------------------------
function join { local IFS="$1"; shift; echo "$*"; }

#--------------------------------Functions--------------------------------------
# brew cask install
bci(){
    brew cask install $@
}

# Check For every Formula
check_individually(){
    echo "Do you want to install $@"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) bci $@; break;;
            No ) break;;
        esac
    done
}

# Check Yes No Individually
check(){
    echo "Do you want to install $1"
    shift
    list=$(join , $@)
    echo "This package includes: \n $list" 
    select yn in "Yes" "No" "Individually"; do
        case $yn in
            Yes ) install_package $@; break;;
            Individually ) install_package_individually $@; break;;
            No ) break;;
        esac
    done
}
# Install packages
install_package(){
    for formula in "$@"
    do
        bci $formula
    done
}

install_package_individually(){
    for formula in "$@"
    do
        check_individually $formula
    done
}

#-------------------------------------------------------------------------------
# Install Software Packages
install_software(){
    check "Office / Documentation"         "${OfficeFormulae[@]}"
    check "Cloud"                          "${CloudFormulae[@]}"
    check "Messenger / Social Networks"    "${MessengerFormulae[@]}"
    check "Music / Video / Media"          "${MediaFormulae[@]}"
    check "Design"                         "${DesignFormulae[@]}"
    check "Development / IT-Tools"         "${DeveloperFormulae[@]}"
    check "Browser"                        "${BrowserFormulae[@]}"
    check "Utilities"                      "${UtilitiesFormulae[@]}"
    check "Extras"                         "${ExtraFormulae[@]}"
}

install_shell_tools(){
    for t in "${ShellTools[@]}"
    do
        brew install $t
    done
}
#-------------------------------------------------------------------------------

# Xcode Monokai Theme
install_monokai_xcode_theme(){
    curl -OL https://gist.github.com/C-M-Hoeller/174e23e1ffc92a3d60c15d5aa5391750/archive/745046a01b992491c54d1357b3248292cd4ea2c3.zip
    echo ""
    echo "Download done"
    echo ""
    unzip 745046a01b992491c54d1357b3248292cd4ea2c3
    echo ""
    echo "Unzip File done"
    echo ""

    if [ ! -d ~/Library/Developer/Xcode/UserData/FontAndColorThemes ]; 
        then mkdir ~/Library/Developer/Xcode/UserData/FontAndColorThemes && echo "Folder Created"
        mv ./174e23e1ffc92a3d60c15d5aa5391750-745046a01b992491c54d1357b3248292cd4ea2c3/Monokai.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/Monokai.xccolortheme
    fi

    if [ -f ~/Library/Developer/Xcode/UserData/FontAndColorThemes/Monokai.xccolortheme ]; 
        then echo "Theme installed"
        else echo "Something went wrong, you can try to installing it manually https://gist.github.com/a-voronov/f99782561021e17537db82aaf1e55d97"
    fi
}

# Add Spacer
add_spacer(){
    while true; do
        read -p "How many spacer do you want? (The Number has to be <= 10): " count
        for i in $(eval echo "{1..$count}")
        do
            defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
            killall Dock
        done
        
        break;
    done
}

#--------------------------------Programm---------------------------------------
echo ""
echo "Welcome to SpiritLabs MacOS reinstall script! (SMRS)"
echo "This script is for everyone who wants a fast solution for installing  multiple apps and tools after fresh macOS installation."
echo "To achieve this we are using some third-party tools, like Brew, Oh-My-Zsh and more."
echo "The full documentation is on our Github repository README"
echo ""
echo "Let's start..."

which -s brew
if [[ $? != 0 ]] ; then
    echo "Do you want to install Brew?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; break;;
            No ) brewCheck = false; break;;
        esac
    done
fi

which -s brew
if [[ $? == 0 ]]; then
    echo "Do you want some helpful Shell Tools?"
    echo "${ShellTools[@]}"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) install_shell_tools; break;;
            No ) break;;
        esac
    done
fi

which -s brew
if [[ $? == 0 ]]; then
    echo "Do you want to install Software?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) install_software; break;;
            No ) break;;
        esac
    done
fi

echo "Next we want to install Oh-My-Zsh"
echo "Do you want to install Oh-My-Zsh?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"; break;;
        No ) break;;
    esac
done

echo "Do you want to setup Oh-My-Zsh now?"
echo "You can do that after running this Script by typing vim ~/.zshrc"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) vim ~/.zshrc; break;;
        No ) break;;
    esac
done

echo "Do you want to install a monokai theme for your Xcode?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) install_monokai_xcode_theme; break;;
        No ) break;;
    esac
done

echo "Do want some spacer in your Dock?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) add_spacer; break;;
        No ) break;;
    esac
done