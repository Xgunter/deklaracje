#!/bin/bash
# Instalacja e-deklaracji i e-pitów na Linuksie 
# Wersja 0.1 
# Na podstawie rozwiązania http://nocnypingwin.pl/e-deklaracje-pod-linuxem-2017/
# Z wykorzystaniem https://aur.archlinux.org/cgit/aur.git/snapshot/adobe-air.tar.gz
# Nie pobiera tworzy plik adobe-air, pozostawiłem opis autora Spider.007 / Sjon
# Zlepił w całość i pokolorował :) gunter

cd /tmp/

cat <<__CONF__ | tee $HOME/.local/share/applications/test.desktop
[Desktop Entry]
Name=e-Pity
Comment=e-Pity
Type=Application
Terminal=false
Categories=Application;Office;
Exec=$HOME/adobe-air-sdk/adobe-air/adobe-air  $HOME/adobe-air-sdk/e-pity/setup_e-pity2017Linux.air
Icon=$HOME/adobe-air-sdk/e-pity/e-pity.png
__CONF__

#sudo\su
if command -v sudo >/dev/null; then sprawdz=$(echo sudo sh -c) ; else sprawdz=$(echo su -c) ; fi

#depends_p
e_dep_p(){
command -v apt >/dev/null 2>&1 || { echo >&2 "To nie jest dystrybucja deb."; exit 1; }
$sprawdz " dpkg --add-architecture i386; apt-get update;
apt-get install libgtk2.0-0:i386 libstdc++6:i386 libxml2:i386 libxslt1.1:i386 libcanberra-gtk-module:i386\
		gtk2-engines-murrine:i386 libqt4-qt3support:i386 libgnome-keyring0:i386 libnss-mdns:i386 libnss3:i386 -y;

ln -s /usr/lib/i386-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0;
ln -s /usr/lib/i386-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0;

touch /usr/bin/e-pity;
chmod +x /usr/bin/e-*;

cat > /usr/bin/e-pity <<EOF
#!/bin/bash
$HOME/adobe-air-sdk/adobe-air/adobe-air  $HOME/adobe-air-sdk/e-pity/setup_e-pity2017Linux.air
EOF
"
}

#depends_d
e_dep_d(){
command -v apt >/dev/null 2>&1 || { echo >&2 "To nie jest dystrybucja deb."; exit 1; }
$sprawdz "dpkg --add-architecture i386; apt-get update;
apt-get install wget unzip -y;
wget ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i386linux_enu.deb;
dpkg -i AdbeRdr9.5.5-1_i386linux_enu.deb;
apt-get install -f -y;

apt-get install libgtk2.0-0:i386 libstdc++6:i386 libxml2:i386 libxslt1.1:i386 libcanberra-gtk-module:i386\
		gtk2-engines-murrine:i386 libqt4-qt3support:i386 libgnome-keyring0:i386 libnss-mdns:i386 libnss3:i386 -y;

ln -s /usr/lib/i386-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0;
ln -s /usr/lib/i386-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0;

touch /usr/bin/e-deklaracje;
chmod +x /usr/bin/e-*;

cat > /usr/bin/e-deklaracje <<EOF
#!/bin/bash
$HOME/adobe-air-sdk/adobe-air/adobe-air $HOME/adobe-air-sdk/e-deklaracje/e-DeklaracjeDesktop.air
EOF
"
}

#depends_o
e_dep_o(){
command -v apt >/dev/null 2>&1 || { echo >&2 "To nie jest dystrybucja deb."; exit 1; }
$sprawdz "dpkg --add-architecture i386; apt-get update;
apt-get install wget unzip -y;
wget ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i386linux_enu.deb;
dpkg -i AdbeRdr9.5.5-1_i386linux_enu.deb;
apt-get install -f -y;

apt-get install libgtk2.0-0:i386 libstdc++6:i386 libxml2:i386 libxslt1.1:i386 libcanberra-gtk-module:i386\
		gtk2-engines-murrine:i386 libqt4-qt3support:i386 libgnome-keyring0:i386 libnss-mdns:i386 libnss3:i386 -y;

ln -s /usr/lib/i386-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0;
ln -s /usr/lib/i386-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0;

touch /usr/bin/e-deklaracje;
chmod +x /usr/bin/e-*;

cat > /usr/bin/e-deklaracje <<EOF
#!/bin/bash
$HOME/adobe-air-sdk/adobe-air/adobe-air $HOME/adobe-air-sdk/e-deklaracje/e-DeklaracjeDesktop.air
EOF

touch /usr/bin/e-pity;
chmod +x /usr/bin/e-*;

cat > /usr/bin/e-pity <<EOF
#!/bin/bash
$HOME/adobe-air-sdk/adobe-air/adobe-air  $HOME/adobe-air-sdk/e-pity/setup_e-pity2017Linux.air
EOF
"
}

#AdobeAIRSDK
e_air(){
command -v apt >/dev/null 2>&1 || { echo >&2 "Nie tu i nie teraz."; exit 1; }
wget http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRSDK.tbz2
mkdir $HOME/adobe-air-sdk
tar jxf AdobeAIRSDK.tbz2 -C $HOME/adobe-air-sdk

mkdir $HOME/adobe-air-sdk/adobe-air
cat << 'TXT' > $HOME/adobe-air-sdk/adobe-air/adobe-air
#!/bin/bash
# Simple Adobe Air SDK wrapper script to use it as a simple AIR application launcher
# By Spider.007 / Sjon

if [[ -z "$1" ]]
then
	echo "Please supply an .air application as first argument"
	exit 1
fi

tmpdir=`mktemp -d /tmp/adobeair.XXXXXXXXXX`

echo "adobe-air: Extracting application to directory: $tmpdir"
mkdir -p $tmpdir
unzip -q $1 -d $tmpdir || exit 1

echo "adobe-air: Attempting to start application"
$HOME/adobe-air-sdk/bin/adl -nodebug $tmpdir/META-INF/AIR/application.xml $tmpdir

echo "adobe-air: Cleaning up temporary directory"
rm -Rf $tmpdir && echo "adobe-air: Done"
TXT

chmod +x $HOME/adobe-air-sdk/adobe-air/adobe-air
}

#e-deklaracje
e_dek(){
command -v apt >/dev/null 2>&1 || { echo >&2 "Pa pa pa."; exit 1; } 
mkdir $HOME/adobe-air-sdk/e-deklaracje
wget http://www.finanse.mf.gov.pl/documents/766655/1196444/e-DeklaracjeDesktop.air
cp e-DeklaracjeDesktop.air $HOME/adobe-air-sdk/e-deklaracje/

unzip /tmp/e-DeklaracjeDesktop.air
cp /tmp/assets/icons/icon128.png  $HOME/adobe-air-sdk/e-deklaracje/e-deklaracje.png

mkdir $HOME/.local/share/applications

cat <<__CONF__ | tee e-deklaracje.desktop
[Desktop Entry]
Name=e-Deklaracje
Comment=e-Deklaracje
Type=Application
Terminal=false
Categories=Application;Office;
Exec=$HOME/adobe-air-sdk/adobe-air/adobe-air $HOME/adobe-air-sdk/e-deklaracje/e-DeklaracjeDesktop.air
Icon=$HOME/adobe-air-sdk/e-deklaracje/e-deklaracje.png
__CONF__

chmod +x e-deklaracje.desktop
cp e-deklaracje.desktop  $HOME/.local/share/applications/
}

#e-pity
e_pit(){
command -v apt >/dev/null 2>&1 || { echo >&2 "nastepnym razem."; exit 1; }
mkdir $HOME/adobe-air-sdk/e-pity
mkdir $HOME/.local/share/applications

wget -O $HOME/adobe-air-sdk/e-pity/setup_e-pity2017Linux.air http://download.e-pity.pl/down/setup_e-pity2017Linux.air

cat <<__CONF__ | tee e-pity.desktop
[Desktop Entry]
Name=e-Pity
Comment=e-Pity
Type=Application
Terminal=false
Categories=Application;Office;
Exec=$HOME/adobe-air-sdk/adobe-air/adobe-air  $HOME/adobe-air-sdk/e-pity/setup_e-pity2017Linux.air
Icon=$HOME/adobe-air-sdk/e-pity/e-pity.png
__CONF__

wget -O $HOME/adobe-air-sdk/e-pity/e-pity.png https://www.e-pity.pl/cms/img/u/program/e-pity-przez-internet-2017-18-pudelko.png   
chmod +x e-pity.desktop
cp e-pity.desktop $HOME/.local/share/applications/
}

##==============RPM==========================##
#fedora
fedora(){
command -v dnf >/dev/null 2>&1 || { echo >&2 "To nie jest Fedora."; exit 1; }

sudo sh -c "touch /usr/bin/e-deklaracje;
chmod +x /usr/bin/e-*;

cat > /usr/bin/e-deklaracje <<EOF
#!/bin/bash
$HOME/adobe-air-sdk/adobe-air/adobe-air  $HOME/adobe-air-sdk/e-pity/setup_e-pity2017Linux.air
EOF"

sudo dnf upgrade nss libgnome-keyring libxslt -y
wget ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i486linux_enu.rpm
sudo dnf install  AdbeRdr9.5.5-1_i486linux_enu.rpm -y
sudo dnf  install libgnome-keyring.i686 nss.i686 rpm-build libxslt.i686 -y
wget airdownload.adobe.com/air/lin/download/2.6/adobeair.i386.rpm
sudo dnf install adobeair.i386.rpm -y

wget http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRSDK.tbz2
mkdir $HOME/adobe-air-sdk
tar jxf AdobeAIRSDK.tbz2 -C $HOME/adobe-air-sdk

mkdir $HOME/adobe-air-sdk/adobe-air
cat << 'TXT' > $HOME/adobe-air-sdk/adobe-air/adobe-air
#!/bin/bash
# Simple Adobe Air SDK wrapper script to use it as a simple AIR application launcher
# By Spider.007 / Sjon

if [[ -z "$1" ]]
then
	echo "Please supply an .air application as first argument"
	exit 1
fi

tmpdir=`mktemp -d /tmp/adobeair.XXXXXXXXXX`

echo "adobe-air: Extracting application to directory: $tmpdir"
mkdir -p $tmpdir
unzip -q $1 -d $tmpdir || exit 1

echo "adobe-air: Attempting to start application"
$HOME/adobe-air-sdk/bin/adl -nodebug $tmpdir/META-INF/AIR/application.xml $tmpdir

echo "adobe-air: Cleaning up temporary directory"
rm -Rf $tmpdir && echo "adobe-air: Done"
TXT

chmod +x $HOME/adobe-air-sdk/adobe-air/adobe-air
mkdir $HOME/adobe-air-sdk/e-deklaracje
wget http://www.finanse.mf.gov.pl/documents/766655/1196444/e-DeklaracjeDesktop.air
cp e-DeklaracjeDesktop.air $HOME/adobe-air-sdk/e-deklaracje/

unzip /tmp/e-DeklaracjeDesktop.air
cp /tmp/assets/icons/icon128.png  $HOME/adobe-air-sdk/e-deklaracje/e-deklaracje.png

cat <<__CONF__ | tee $HOME/.local/share/applications/e-deklaracje.desktop
[Desktop Entry]
Name=e-Deklaracje
Comment=e-Deklaracje
Type=Application
Terminal=false
Categories=Application;Office;
Exec=$HOME/adobe-air-sdk/adobe-air/adobe-air $HOME/adobe-air-sdk/e-deklaracje/e-DeklaracjeDesktop.air
Icon=$HOME/adobe-air-sdk/e-deklaracje/e-deklaracje.png
__CONF__

chmod +x $HOME/.local/share/applications/e-deklaracje.desktop
}

#suse
suse(){
command -v zypper >/dev/null 2>&1 || { echo >&2 "To nie jest Suse."; exit 1; }
sudo zypper -n install libxslt1-32bit libgnome-keyring0-32bit mozilla-nss-32bit libstdc++6-32bit libgtk-2_0-0-32bit libgthread-2_0-0-32bit

sudo sh -c "touch /usr/bin/e-pity;
chmod +x /usr/bin/e-*;

cat > /usr/bin/e-pity <<EOF
#!/bin/bash
$HOME/adobe-air-sdk/adobe-air/adobe-air  $HOME/adobe-air-sdk/e-pity/setup_e-pity2017Linux.air
EOF"

wget http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRSDK.tbz2
mkdir $HOME/adobe-air-sdk
tar jxf AdobeAIRSDK.tbz2 -C $HOME/adobe-air-sdk

mkdir $HOME/adobe-air-sdk/adobe-air
cat << 'TXT' > $HOME/adobe-air-sdk/adobe-air/adobe-air
#!/bin/bash
# Simple Adobe Air SDK wrapper script to use it as a simple AIR application launcher
# By Spider.007 / Sjon

if [[ -z "$1" ]]
then
	echo "Please supply an .air application as first argument"
	exit 1
fi

tmpdir=`mktemp -d /tmp/adobeair.XXXXXXXXXX`

echo "adobe-air: Extracting application to directory: $tmpdir"
mkdir -p $tmpdir
unzip -q $1 -d $tmpdir || exit 1

echo "adobe-air: Attempting to start application"
$HOME/adobe-air-sdk/bin/adl -nodebug $tmpdir/META-INF/AIR/application.xml $tmpdir

echo "adobe-air: Cleaning up temporary directory"
rm -Rf $tmpdir && echo "adobe-air: Done"
TXT

chmod +x $HOME/adobe-air-sdk/adobe-air/adobe-air

mkdir $HOME/adobe-air-sdk/e-pity
mkdir $HOME/.local/share/applications

wget -O $HOME/adobe-air-sdk/e-pity/setup_e-pity2017Linux.air http://download.e-pity.pl/down/setup_e-pity2017Linux.air

cat <<__CONF__ | tee $HOME/.local/share/applications/e-pity.desktop
[Desktop Entry]
Name=e-Pity
Comment=e-Pity
Type=Application
Terminal=false
Categories=Application;Office;
Exec=$HOME/adobe-air-sdk/adobe-air/adobe-air  $HOME/adobe-air-sdk/e-pity/setup_e-pity2017Linux.air
Icon=$HOME/adobe-air-sdk/e-pity/e-pity.png
__CONF__

wget -O $HOME/adobe-air-sdk/e-pity/e-pity.png https://www.e-pity.pl/cms/img/u/program/e-pity-przez-internet-2017-18-pudelko.png
chmod +x $HOME/.local/share/applications/e-pity.desktop
}

#menu
tput clear
tput cup 1 9
 
tput setaf 3
echo "Instalacja e-deklaracji i e-pitów"

tput cup 2 8
echo "Na systemy Debian, Ubuntu, Linuxmint"

tput cup 3 7
echo "I wszystkie pozostałe pochodne Debiana"
tput sgr0

tput setaf 1
tput cup 5 14

tput rev
echo "WYBIERZ CO INSTALUJESZ" 
tput sgr0

tput setaf 5 
tput cup 7 12
echo "1. Zainstaluj e-deklaracje"
 
tput cup 8 12
echo "2. Zainstaluj e-pity"
 
tput cup 9 12
echo "3. Obydwa programy"

tput setaf 3
tput cup 11 7
echo "Instalacja aplikacji dla Fedory i Suse"
tput sgr0

tput setaf 5
tput cup 13 12
echo "4. Fedora e-deklaracje"

tput cup 14 12
echo "5. Suse e-pity"

tput setaf 1
tput cup 16 12
echo "6. Jednak nie instaluje nic"

tput setaf 2
tput bold
tput cup 18 5
read -p "Wpisz numer instalacji i naciśnij enter [1-6] " wybor

tput clear
tput sgr0
tput rc

if [[ $wybor == "1"  ]] ; then  
	echo "instaluje e-deklaracje" ; (e_dep_d) ; (e_air) ; (e_dek)
elif [[ $wybor == "2"  ]] ; then 
	echo "instaluje e-pity" ;  (e_dep_p) ; (e_air) ; (e_pit)
elif [[ $wybor == "3"  ]] ; then 
	echo "instaluje e-deklaracje i e-pity" ; (e_dep_o) ; (e_air) ; (e_dek) ; (e_pit)
elif [[ $wybor == "4"  ]] ; then 
	echo "Fedora e-deklaracje" ; (fedora)
elif [[ $wybor == "5"  ]] ; then 
	echo "Suse e-pity" ; (suse)
elif [[ $wybor == "6"  ]] ; then 
	echo "Jednak nie instaluje"
elif [[ $wybor != "1-6"  ]] ; then 
	tput setaf 1; tput bold; tput cup 7 12; echo "źle wybrałeś, uruchom od nowa" ; tput rc
fi