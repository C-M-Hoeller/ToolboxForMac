#!/bin/zsh
# Global Variables
# Cask Formulae
declare -a OfficeFormulae=("typora")
declare -a CloudFormulae=("nextcloud")
declare -a MessengerFormulae=("whatsapp" "discord")
declare -a MediaFormulae=("spotify" "vlc")
declare -a DesignFormulae=("figma")
declare -a DeveloperFormulae=("visual-studio-code" "jetbrains-toolbox" "github" "postman" "teamviewer" "iterm2" "parallels" "docker" "wireshark" "coderunner")
declare -a BrowserFormulae=("google-chrome" "firefox" "cleanmymac")
declare -a UtilitiesFormulae=("numi" "oversight" "rocket" "hiddenbar" "monitorcontrol")

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
    echo "This package includes ($2)"
    select yn in "Yes" "No" "Individually"; do
        case $yn in
            Yes ) $3; break;;
            Individually ) $4; break;;
            No ) break;;
        esac
    done
}

### CASK Formulae ###
# Office / Documentation
install_office(){
    for formula in "${OfficeFormulae[@]}"
    do
        bci $formula
    done
}
install_office_individually(){
    for formula in "${OfficeFormulae[@]}"
    do
        check $formula
    done
}

# Cloud
install_cloud(){
    for formula in "${CloudFormulae[@]}"
    do
        bci $formula
    done
}
install_cloud_individually(){
    for formula in "${CloudFormulae[@]}"
    do
        check $formula
    done
}

# Messenger
install_messenger(){
    for formula in "${MessengerFormulae[@]}"
    do
        bci $formula
    done
}
install_messenger_individually(){
    for formula in "${MessengerFormulae[@]}"
    do
        check $formula
    done
}

# Media
install_media(){
    for formula in "${MediaFormulae[@]}"
    do
        bci $formula
    done
}
install_media_individually(){
    for formula in "${MediaFormulae[@]}"
    do
        check $formula
    done
}

# Design
install_design(){
    for formula in "${DesignFormulae[@]}"
    do
        bci $formula
    done
}
install_desgin_individually(){
    for formula in "${DesignFormulae[@]}"
    do
        check $formula
    done
}

# Development
install_development(){
    for formula in "${DeveloperFormulae[@]}"
    do
        bci $formula
    done
}
install_development_individually(){
    for formula in "${DeveloperFormulae[@]}"
    do
        check $formula
    done
}

# Browser
install_browser(){
    for formula in "${BrowserFormulae[@]}"
    do
        bci $formula
    done
}
install_browser_individually(){
    for formula in "${BrowserFormulae[@]}"
    do
        check $formula
    done
}

# Utilities
install_utilities(){
    for formula in "${UtilitiesFormulae[@]}"
    do
        bci $formula
    done
}
install_utilities_individually(){
    for formula in "${UtilitiesFormulae[@]}"
    do
        check $formula
    done
}
###--------------####

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
        else echo "Something went wrong, You can try to install it manually https://gist.github.com/a-voronov/f99782561021e17537db82aaf1e55d97"
    fi
}

# Add Spacer
add_spacer(){
    while true; do
        read -p "How many Spacer do you want? (The Number has to be <= 10): " count
        echo $count
        for i in $(eval echo "{1..$count}")
        do
            defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
            killall Dock
        done
        
        break;
    done
}

echo ""
echo "Welcome to SpiritLabs MacOS reinstall script! (SMRS)"
echo "This Script is for everyone who wants a fast solution to install a lot of Apps and Tools after reinstall MacOS"
echo "To achieve this we are using some other tools, like Brew, Oh-My-Zsh and more."
echo "The full Documentation is on our Github Repositories README"
echo ""
echo "Let's start..."
echo "First we want to install Brew and Cask"

echo "Do you want to install Brew?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; break;;
        No ) break;;
    esac
done
echo "Do you want to install Cask?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) brew install cask; break;;
        No ) break;;
    esac
done

echo "Now we want to install some Software"
echo ""
check "Office / Documentation"         $OfficeFormulae         "install_office"        "install_office_individually"
check "Cloud"                          $CloudFormulae          "install_cloud"         "install_cloud_individually"
check "Messenger / Social Networks"    $MessengerFormulae      "install_messenger"     "install_messenger_individually"
check "Music / Video / Media"          $MediaFormulae          "install_media"         "install_media_individually"
check "Design"                         $DesignFormulae         "install_design"        "install_desgin_individually"
check "Development / IT-Tools"         $DeveloperFormulae      "install_development"   "install_development_individually"
check "Browser"                        $BrowserFormulae        "install_browser"       "install_browser_individually"
check "Utilities"                      $UtilitiesFormulae      "install_utilities"     "install_utilities_individually"

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

echo "Do you want a Monokai Theme for your Xcode"
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