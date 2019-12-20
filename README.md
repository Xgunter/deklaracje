## Spis treści
* [Deklaracje podatkowe opis.](#deklaracje-podatkowe)
* [Uwagi.](#uwaga)
* [Instalacja.](#instalacja)
* [Działa na dystrybucjach, testowane na.](#testowane-na)
* [Bezpieczeństwo.](#bezpieczeństwo)
    * [Kopia zapasowa.](#backup)
    * [Aktualizacja.](#upgrade)
    * [Odpowiedzialność.](#odpowiedzialność)
* [Licencja.](#licencjonowanie)


## Deklaracje podatkowe. 
Deklaracje podatkowe w systemie Linux. [Skrypt działa na dystrybucjach.](https://github.com/Xgunter/deklaracje/blob/master/README.md#testowane-na)

Skrypt instalujący e-deklaracje i e-pity na systemie Debian i pochodnych, jak Ubuntu, Mint i inne.  
Testowo Fedora i OpenSuse.

Skrypt opiera się o rozwiązania nocnegopingwina, opisane na tej stronie. 
http://nocnypingwin.pl/e-deklaracje-pod-linuxem-2017 

Oraz na podstawie paczki ze skryptem z Archlinuksa. 
http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRSDK.tbz2

Skrypt ułatwiający instalacje aplikacji do rozliczeń podatków e-deklaracje i e-pity, działa na wszystkich 
„deb-ianowych” dystrybucjach, jak Debian, Ubuntu, Linuxmint, jak również na Fedorze i Suse (z tym że na rpm-ach 
trzeba traktować to testowo). Na OpenSuse Tumbleweed nie działa Adobereader, który to program jest podstawowym 
komponentem e-deklaracji, dlatego do momentu rozwiązania tego problemu jest dostępna możliwość instalacji tylko
e-pitów na suse. 
Na architekturze 64-bitowej jak i na 32-bitowej, z sudo i bez, i nie tylko na Gnome i Kde. Jeżeli coś się nie 
powiodło trzeba powtórzyć instalacje, czasami wyczyścić /tmp z nie w pełni pobranych plików 
(przy zerwaniu połączenia internetowego, na przykład), może być pytanie o nadpisanie istniejących paczek. 

## Uwaga: 
Ze względu na to, że na systemach 64-bitowych potrzebne są biblioteki i programy 32-bitowe, do uruchomienia 
AdobeAIR i adobe readera (niezbędny w e-deklaracjach),to do instalacji potrzeba na tych systemach sporo miejsca. 
I tak.

**Do pobrania są (do instalacji e-pity nie pobierany jest Adobe reader):**
* Adobe reader  - 60MB – po zainstalowaniu 130MB 
* AdobeAIRSDK   - 34MB - po rozpakowaniu    65MB
* e-Deklaracje  -  2MB - nierozpakowywane   2MB 
* e-Pity        - 13MB - nierozpakowywane  13MB
* 32-bitowe zależności opisane niżej. 

Do tego pobierane są niezbędne paczki 32-bitowe, potrzebne do działania tych programów (jak ktoś już używał
32-bitowych aplikacji, będzie niewiele do zainstalowania). Są to wartości różnie, zależy od architektury i 
systemu, jak i dystrybucji. Razem z powyższymi programami, będzie do pobrania od 100MB-300MB (mówimy tu o 
wszystkim, instalacji obydwóch aplikacji i Adobe readera razem z AdobeAIRSDK, oraz potrzebnych zależności 
32-bitowych), co po rozpakowaniu zajmie na dysku od 200MB (Debian 32-bit, co zrozumiałe prawie całe środowisko 
gotowe, instaluje w zasadzie tylko aplikacje i minimum zależności), do nawet ponad 400MB (na suse, trzeba 
pamiętać że po pobraniu potrzebne jest miejsce do zainstalowania, później można wyczyść archiwum pobranych 
paczek). Jest to niewiele więcej jak byśmy zainstalowali Adobeair, a nie AdobeAIRSDK (różnica paczek to 
około 20MB-30MB). Jak widać do instalacji potrzeba sporo miejsca, razem z plikami tymczasowymi w tmp i
paczkami pobranymi do cache instalatora.  

## Instalacja
Uruchomić jako użytkownik, nie root.

Albo, pobieramy skrypt ze strony https://github.com/Xgunter/deklaracje i w konsoli, lub od razu w konsoli.

Pobrać.

```wget https://raw.githubusercontent.com/Xgunter/deklaracje/master/deklaracje.sh```

Nadać uprawnienia do uruchamiania.

```chmod +x deklaracje.sh```

I uruchomić

```./deklaracje.sh```

Lub, **jednym poleceniem w konsoli** można. (Uważać na skopiowanie całej linii.)

```cd /tmp; wget https://raw.githubusercontent.com/Xgunter/deklaracje/master/deklaracje.sh; chmod +x deklaracje.sh; ./deklaracje.sh```

W terminalu pojawi się menu z wyborem, wpisujemy numer instalacji i zatwierdzamy klawiszem enter. 

![deklaracje instaler](https://github.com/Xgunter/deklaracje/blob/master/docs/menu.png)

* Do instalacji zależności z repozytoriów dystrybucji, należy podać hasło root-a.
* Pierwsze uruchomienie czasami trwa długo, zwłaszcza jak nie mieliśmy środowiska 32-bitowgo. 

Po zainstalowaniu w menu startowym - biuro powinna być możliwość uruchomienia e-deklaracji, 
czy e-pitów, można uruchomić w konsoli wpisując adekwatnie do nazwy e-deklaracje i e-pity.

![deklaracje start](https://github.com/Xgunter/deklaracje/blob/master/docs/start.png)

Jeżeli chcemy używać e-deklaracji musimy zaakceptować licencje Adobe-readera.

![deklaracje reader](https://github.com/Xgunter/deklaracje/blob/master/docs/reader.png)

Na niektórych dystrybucjach będzie alert SSL Certificate. Z pytaniem czy ufamy, w tym wypadku 
rządowej stronie bramka.e-deklaracje.mf.gov.pl i chcemy się z nią połączyć, 
zatwierdzamy jak chcemy korzystać z e-deklaracji.

![deklaracje ssl](https://github.com/Xgunter/deklaracje/blob/master/docs/ssl.png)



## Testowane na.
* **Debian stabilny, testowy, niestabilny**, obydwie architektury i368 i x64 – nie ma problemów
* **Ubuntu-16.04 do 17.10** 32bit/64bit -nie ma problemów
* **Ubuntu-18.04 do 19.10, testowa 20.04** - nie ma problemów. 
    Pakiety potrzebne do działania e-deklaracji i e-pitów zostały przeniesione do repozytoriów **universe**, 
    dlatego trzeba mieć je dodane. **Dodawane są automatycznie**, można sprawdzić sources.list.
    Na przykład dla 18.04 w /etc/apt/sources.list na końcu linii z adresem oficjalnym dodane słowo universe.  
    Przykład.
    
```http://archive.ubuntu.com/ubuntu/ bionic main restricted universe```
         
* **Linuxmint-18.3 do 19.3** działa. Było z mate, programy działają prawidłowo, tylko nie czyta czasami 
    skrótów startowych desktop. Albo uruchamiamy z terminala odpowiednio wpisując e-deklaracje, e-pity, 
    albo kopiujemy na Pulpit/Desktop.
  
```cp  $HOME/.local/share/applications/e-*.desktop  $HOME/Pulpit/```
* **Na wszystkich pochodnych Ubuntu i Debiana**, powinno działać, sprawdzić czy na "Ubuntowych" jest dodane
    repozytorium universe, mint ma dodane domyślnie.
* **deepin-15.5**-amd64 - tak samo jak Linuxmint ma problemy z aktywatorami desktop, ale można 
  uruchomić z konsoli e-deklaracje e-pity, pierwsze uruchamiania długie (może i z minutę), 
  tak jak pisałem budowanie środowiska 32-bitowego na systemie 64-bitowym.
* **Fedora 27**-64bity – nie ma problemów, nie dodałem możliwości instalacji e-pitów, ale sprawdzałem
  działają prawidłowo.
* **OpenSuse Tumbleweed** - nie działa adobe reader, niezbędny do e-deklaracji, e-pity działają prawidłowo 
  na systemie 32-bity i 64 bity.
* **OpenSUSE-13.2** – e-deklaracje i e-pity działają prawidłowo, ze względów opisanych wyżej dodana jest
  tylko możliwość instalacji e-pitów.

* Przy informacji.

```
Gtk-Message: Failed to load module "gail"
Gtk-Message: Failed to load module "atk-bridge"
```
Można doinstalować libatk-adaptor:i386 libgail-common:i386

## Backup 
Kopie utworzonych wpisów i ustawień e-deklaracji w Debianie i pochodnych, możemy zrobić w taki sposób.

```zip -r deklaracje_backup.zip  ~/.appdata/```

lub bez pełnej sciezki, teraz dla odmiany może tar-em.

```tar -zcvf deklaracje_backup.tgz .appdata/```

## Bezpieczeństwo.
Wszystkie paczki pobierane są z oficjalnych serwerów twórców aplikacji i repozytoriów danej dystrybucji 
Linuksa. Z wyłączeniem Adobe readera (instalowany w /opt/adobe) i paczek z repozytoriów dystrybucji, 
wszystko rozmieszczane jest w katalogu użytkownika, z jego uprawnieniami, a nie root-a.   
Można skrypt uruchomić na livecd, konieczne minimum 2GB RAM. 

## Upgrade

Wystarczy w miejsce starych paczek (są przetrzymywanie spakowane), wkleić nowe.

## Odpowiedzialność.

Robicie wszystko na swoją odpowiedzialność, sprawdzajcie skrypty z których instalujecie.

## Licencjonowanie.

Rozwiązanie jest autorskie i pochodzi z tej strony http://nocnypingwin.pl/e-deklaracje-pod-linuxem-2017 , 
a co do skryptu to jak widać GPL3.
