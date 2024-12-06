
Erfan Karimi  10.12.2024

# Debian Workshop Anleitung 
Hallo, bitte befolge die Schritte. Das Ganze ist so gedacht, dass am Ende etwas übrig bleibt, also hab kein Stress.

### Links:
Dieser Anleitung findest du auch unter:

![Github doc](barcode.png "Github access point")

**Markdown**: [github.com/picupup/debian-workshop-2024/blob/main/doc/README.md](https://github.com/picupup/debian-workshop-2024/blob/main/doc/README.md) 

**PDF**: [erfanmedia.de/debian/workshop/debian-workshop.pdf](https://erfanmedia.de/debian/workshop/debian-workshop.pdf)

## Notizen:
- **Spitzen Klammer**: Überall, wo ein Begriff in einer Spitzen Klammer steht, musst du diesen ersetzen, z.B. `<schreibe deine name>`.
- **Tilde „~“**: Das Tilde repräsentiert dein Home-Verzeichnis in Unix/Linux-Umgebungen. `/home/<Nutzer>/`

## Vim:
Mit „vim <Datei>“ kannst du eine Datei zum Bearbeiten oder Lesen öffnen. Benutze „i“, um in den Insert-Modus zu gehen, wo man die Datei ändern kann. Zum Speichern und Beenden drücke „ESC“ und gebe „:wq“ ein.

# 1. SSH-Zugang einrichten
Für die Bearbeitung der Schritte musst du dich mit einem „remote-server“ verbinden.\
**Nutzernummer/port**: Für deinen Nutzer wähle bitte ein Server ([Auch verfügbar in paired\_ports.txt](https://github.com/picupup/debian-workshop-2024/blob/main/doc/paired_ports.txt)):

```txt
Server	:	Port 1	-	Port 2
#Port>
1	:	587	-	990
2	:	993	-	995
3	:	3306	-	3389
4	:	5900	-	8000
5	:	8009	-	8883
6	:	9001	-	20000
7	:	20001	-	20003
8	:	20007	-	20009
9	:	20019	-	20020
10	:	20026	-	20041
11	:	20044	-	20045
12	:	20052	-	20059
13	:	20062	-	20069
14	:	20078	-	20081
15	:	20090	-	20097
16	:	20098	-	20105
17	:	20111	-	20112
18	:	20124	-	20129
19	:	20135	-	20140
20	:	20148	-	20154
#Port<
```

## SSH Config:
Schreibe bitte folgendes in deine `~/.ssh/config` Datei.

```bash
Host debianworkshop
    hostname erfanmedia.de
    user root
    port <Port 1>
```

## SSH-Identität austauschen:
Wenn du dich im vorherigen Schritt mit dem Server verbunden hast, dann ist es an der Zeit, deine „Digitale Identität“ mit dem Server auszutauschen, damit du dich ohne Passwort einloggen kannst.

### ssh-keygen:
Existiert die Datei `~/.ssh/id_ed25519.pub` auf deinem Rechner? Wenn nicht, bedeutet dies, dass du noch keine „digitale SSH-Identität“ hast. In diesem Fall gib den Befehl `ssh-keygen` im Terminal ein und drücke immer „Enter“, bis es fertig ist.

```bash
ssh-keygen -t ed25519
```

### Alternative Version für Automatisierung:
```bash
ssh-keygen -t ed25519 -N "" -f /home/${user}/.ssh/id_ed25519 <<<"y"
```

## Verbindung testen:
Für das Testen bitte einmal folgendes aufrufen und bei der Anfrage „yes“ eingeben und bestätigen:

```ssh
ssh debianworkshop
```

### ssh-copy-id:
Mit folgendem Befehl teilst du deine Identität mit dem Server:

```bash
ssh-copy-id debianworkshop
```

Jetzt solltest du dich ohne Eingabe des Passwortes auf dem Server einloggen können.

```bash
ssh debianworkshop
```

## Die Willkommensnachricht entfernen
Wenn du dich per SSH auf dem Server anmeldest, erscheint eine Nachricht wie `The programs....` Diese Nachricht wird in der Datei `/etc/motd` gespeichert. Um die Nachricht zu entfernen, kannst du die Datei wie folgt leeren:

```bash
> /etc/motd
```

Du kannst auch mit vim etwas darein schreiben.

### SSH port ändern
In diesem abschnitt fügen wir einen alternativen ssh-port zu `openssh-server` config.

Mit 

```bash
vim /etc/ssh/sshd_config
```
 die config Datei aufmachen `i` drucken und nach der Zeile `Port 22` folgendes einfügen: 

```bash 
Port <Port 2>
```
Dann mit 

```bash
service ssh restart
```
 den openssh-server neustarten. Achtung die sitzung beendet sich. **Und versuchen über neuen Port den Server zu erreichen: 

```ssh
ssh -p <Port 2> root@erfanmedia.de
```

# 2. Befehl Installieren

Damit du deine erste Erfahrung mit der Installation von Befehlen hast, bitte installiere folgende Befehle `pwgen`. Damit kannst du Passwörter erstellen. Mit dem `sudo`-Befehl können berechtigte Nutzer Befehle als root-Nutzer ausführen. So installiert man sie:

```bash
apt-get install -y pwgen sudo
```

Nach der Installation versuche es zu testen, um ein Passwort der Länge 12 zu generieren:

```bash
pwgen 12 1
```

# 3. Standard Zeit-Zone ändern

Ist die Zeit richtig?
 
```bash
date
```

Mit dem Befehl „date“ vergleiche die Zeit des Servers mit der von deinem Handy. Die Zeit ist nicht auf `Europe/Berlin` eingestellt, sondern auf die globale Zeit. Daher bitte die folgenden Schritte befolgen, um die Zeitzone anzupassen.

```bash
apt-get install -y tzdata
```
```bash
ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
echo "Europe/Berlin" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata
```

Nun vergleiche die Zeit nochmal. Auf dem Server sollte jetzt die richtige Zeit angezeigt werden.

# 4. Nutzer erstellen

Du bist aktuell als „root“-Nutzer eingeloggt. Doch da der „root“-Nutzer alle Rechte auf dem Server hat, ist es nicht sicher, als root eingeloggt zu sein. Du solltest dir einen separaten Nutzer erstellen und damit arbeiten. Root-Rechte werden nur bei der Installation oder Konfiguration von Komponenten benötigt.\

Nun solltest du einen neuen Nutzer erstellen. Achte auf die Spitzen Klammern:

**Spitze Klammer <user> austauchen**

```bash
useradd -m -d /home/<user> -s /bin/bash <user>
chmod 755 /home/<user>
```

Damit erstellst du einen Nutzer mit dem Home-Verzeichnis `/home/<user>` und setzt die Standard-Shell auf `/bin/bash`.

## Erstelle ein Passwort für den Nutzer:

```bash
password="$(pwgen 12 1)"
echo "<Nutzer>:${password}" | sudo chpasswd
echo "Dein Passwort ist $password"
```

## sudo Gruppe:
Damit der neue Nutzer den Befehl `sudo` aufrufen kann, musst du den Nutzer in die „sudo“-Gruppe einfügen. Die Gruppe „sudo“ wurde mit der Installation von `sudo` erzeugt. Doch um zu wissen, wie man eine Gruppe erstellt, gebe folgendes im Terminal ein:

```bash
groupadd sudo
```

Und mit folgendem Code kannst du den Nutzer zur Gruppe `sudo` hinzufügen:

```bash
usermod -aG sudo <Nutzer>
```

# 5. In den neuen Nutzer einloggen

Füge folgendes in die `~/.ssh/config` ein und verbinde dich ab jetzt mit dem neuen Nutzer im Server. Bei der Administration und Installation von Befehlen und Co., nutze den `sudo`-Befehl.

```bash
Host workshopnutzer
    hostname erfanmedia.de
    user <Nutzer>
    port <Dein Port>
```

```bash
ssh-copy-id workshopnutzer
ssh workshopnutzer
```

# 6. OHNE Passwort `sudo` aufrufen

In dem neuen Nutzer befolge die folgenden Punkte, um zukünftig ohne Passwort `sudo` aufrufen zu können.\
**Achtung**, dies stellt ein Sicherheitsrisiko dar. Es wird empfohlen, immer das Passwort einzugeben. Aber hier wird es gezeigt, damit ihr wisst, wie es möglich ist:

Alle selbst erstellten Dateien, die unter `/etc/sudoers.d/*` geschrieben sind, werden für die Konfiguration von Benutzer- und Gruppenrechten erstellt. Die Zahl am Anfang definiert, in welcher Reihenfolge sie beim Start ausgeführt werden.

```bash
sudo vim /etc/sudoers.d/01_nopasswd
```

Füge folgende Regel in dieser Datei hinzu:

```bash
<Nutzer> ALL=(ALL) NOPASSWD: ALL
```

Das erste `ALL` legt fest, dass der Benutzer `<Nutzer>` die Regel auf allen Hosts verwenden kann.\
Das `(ALL)` gibt an, dass `<Nutzer>` Befehle als jeder Benutzer ausführen darf, nicht nur als root.\
Das Schlüsselwort `NOPASSWD` bedeutet, dass `<Nutzer>` kein Passwort eingeben muss, wenn er `sudo` verwendet.\
Das letzte `ALL` gibt an, dass `<Nutzer>` alle Befehle mit `sudo` ausführen darf.\

Speichere und schließe die Datei.

# 7. Apache Server installieren:

„Apache2“ ist ein Webserver. Wir werden diesen installieren. Bitte installiere ihn mit folgendem Befehl:

```bash
sudo apt-get install -y apache2
```

**UTF-8 Aktivieren**:\
Damit die deutschen Umlaute korrekt auf den Webseiten angezeigt werden, füge folgendes in die Datei `/etc/apache2/apache2.conf` ein: `AddDefaultCharset UTF-8`

```bash
sudo sed -ie 's/AccessFileName .htaccess/AccessFileName .htaccess\nAddDefaultCharset UTF-8/' /etc/apache2/apache2.conf 
```

Starte den Apache2 mit:

```bash
sudo service apache2 start
```

## Achtung:
Wir sind aktuell in einer virtuellen Docker-Umgebung. Solltest du Apache2 auf deinem eigenen Server starten wollen, nutze diesen Befehl:

```bash
sudo systemctl start apache2
```

# Besuche der online link

## Besitzer des Web-Verzeichnises ändern

Um daten im Internet anzuzeigen speichert man die Daten unter `/var/www/html`

Da apache als root installiert ist, kann deinen neuen Nutzer nicht in dem Web-Verzeichnis schreiben. Um die Besitzer dieser Verzeichnis zu ändern führe folgendes durch.

```bash
sudo chown <nutzer>:<nutzer> /var/www/html
```

## Im Browser anschauen

Der online link, um zu sehen ob der server ist am laufen ist:

```bash
http://workshop<Server Number>.erfanmedia.de
```

Erstelle einer Datei unter `/var/www/html/`. Zum Beispiel `hallo.txt` und ruffe es über `workshop<Nutzernummer>.erfanmedia.de/hallo.txt` auf.

Sie können auch die `index.html` Datei umändern.

Beispiel:
```bash
echo "Hallo" > /var/www/html/hallo.txt
```
# 8. Skripte Serverweit zugänglich machen
Erstellen sie ein Skript mit sudo unter `/usr/local/bin/` und machen sie es für alle Nutzern ausführbar. Und testen sie es.

Hier ist ein Beispiel:

```bash
sudo tee /usr/local/bin/hallo.sh &>/dev/null <<END
#!/usr/bin/env bash
echo "Hallo das Skript wird hiermit ausgefuehrt. Hier ist die Zeit $(date '+%F_%T')"
END

sudo chmod +x /usr/local/bin/hallo.sh

hallo.sh

```

# 9. Git nutzer erstellen
Hier klonen wir ein paar Skripte. Damit kann man gruppen, Nutzer und git (gitterbret) Nutzer erstellen und benutzen:

1. Git Nutzer erstellen:
```bash
cd; mkdir -p repos; cd repos
git clone https://github.com/picupup/scripts.git
cd scripts
./deploy.sh server
```

3. Git Nutzer-Daten setzen
```bash
  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"
```

4. Ein Beipiel Repo erstellen und klonen:

```bash
create-bare-repo testrepo $USER
cd ~/repos/
git clone /home/git/testrepo.git
```
3. Etwas pushen (Optional)

```bash
cd testrepo
echo "Hallo" > test.txt
git add .
git commit -m 'Erstes Commit'
git push
```

# 10. Firewall mit nftables einrichten
Ab diesem Abschnitt richten wir eine grundlegende Sicherheitskonfiguration für den Server ein, die aus einer Firewall mit nftables, einem Schutz gegen Brute-Force-Angriffe mit Fail2Ban und der Automatisierung von Sicherheitsupdates besteht.

#### **Firewall mit nftables**

`nftables` ist ein modernes und leistungsstarkes Tool zur Verwaltung von Firewalls in Linux.

1.  **Installieren von `nftables`**
    
    ```bash
    sudo apt-get install -y nftables
    ```

2.  **Standardkonfiguration erstellen**  
    Regeldatei Verändern:
    
    ```bash 
    sudo vim /etc/nftables.conf
    ```

    Du solltest die folgende Config in der Datei schreiben. Bitte beobachte die 3. Bestandteile. Es gibt `chain input`, `chain output` und `chain forward` für jeweils eingehende-, ausgehende- und weiterleitende Verbindungen. 


    Füge folgende Regeln hinzu:
    
```txt
#!/usr/bin/nft -f

flush ruleset

table inet filter {
  chain input {
    type filter hook input priority 0;
    
    # Standardaktion: Alle nicht explizit erlaubten Verbindungen werden abgelehnt
    policy drop

    # Erlaube bereits etablierte und verwandte Verbindungen
    ct state {established, related} accept

    # Verbindungen von und zu Loopback-Interface erlauben
    iifname lo accept

    # ICMP (Ping) erlauben
    ip protocol icmp accept
    ip6 nexthdr icmpv6 accept

    # Erlaube SSH, HTTP, HTTPS und Port 8080
    tcp dport {ssh,http,https,8080} accept

    # Alle anderen Verbindungen abweisen mit ICMP-Port-Unreachable
    reject with icmp type port-unreachable
  }

  chain forward {
    type filter hook forward priority 0;
    
    # Standardaktion: Alle Weiterleitungen werden abgelehnt
    policy drop
  }

  chain output {
    type filter hook output priority 0;
    
    # Standardaktion: Alle ausgehenden Verbindungen werden erlaubt
    policy accept
  }
}
```

3.  **Firewall aktivieren** (Anders als üblich)

    Um die Regeln aktivieren und nftables starten, führt man für üblich folgendes durch. Es ist aber in der Workshop umgebung nicht möglich dies zu tuen. 

    ```bash
        sudo systemctl enable nftables
        sudo systemctl start nftables
    ```

    Jedoch für den Workshop, bitte führe folgendes durch nach jede änderung der config Datei: (`nft-update.sh`)
    ```bash
	sudo nft -f /etc/nftables.conf
    ```

4.  **Regeln testen**
    Zum testen bitte einmal den Port http(80) von der config Datei entfernen nftables aktualisieren und beobachten, ob der Apache2 Server noch erreichbar ist? Bitte nicht vergesen den Port weider in der Config-Datei zu schreiben und nft aktualisieren.

    Also um deinen zweiten ssh port auf dem Server freizugeben, füge es in der config; in der folgende Zeile:

    ```bash
    tcp dport {ssh,http,https,8080} accept
    ```

    Also Damit seht ihr die aktuellen Regeln.
    ```bash
    sudo nft list ruleset
    ```
5. **Port über Befehlzeile freischalten**
    ```bash
        nft add rule inet filter input tcp dport <Port 2> accept
    ```

# 11. Automatische Updates mit unattended-upgrades
Sicherheitsupdates automatisch installieren lassen.
1. Installieren von unattended-upgrades

```bash
sudo apt-get install -y unattended-upgrades
```
2. Konfiguration aktivieren

```bash
sudo dpkg-reconfigure unattended-upgrades
```

3. Erweiterte Einstellungen anpassen
Öffne die Konfigurationsdatei:

```bash
sudo vim /etc/apt/apt.conf.d/50unattended-upgrades
```
Überprüfe, ob folgende Einstellungen aktiv sind:

```bash
Unattended-Upgrade::Remove-Unused-Dependencies "true";
# ...
Unattended-Upgrade::Automatic-Reboot "true";
```

4. Testen

Um es zu testen folgendes ausführen:

```bash
sudo unattended-upgrade --debug
```

Die Logs der automatischen Updated findest du hier:

```bash
sudo less /var/log/unattended-upgrades/unattended-upgrades.log
```

# 12. Schutz vor Brute-Force-Angriffen mit Fail2Ban - Für Zuhause
Dies funktioniert nicht auf dem Workshop server.

Fail2Ban schützt den Server vor automatisierten Login-Versuchen.

1. Installieren von Fail2Ban

```bash
    sudo apt-get install -y fail2ban
```

2. Konfiguration anpassen
Erstelle eine lokale Konfigurationsdatei:

```bash
    sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
    sudo vim /etc/fail2ban/jail.local
```
Aktiviere SSH-Schutz und passe die Konfiguration an:

```bash
[sshd]
enabled = true
port = 22,<Port 2>
bantime = 1h
findtime = 10m
maxretry = 3
```

3. Fail2Ban starten

```bash
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

4. Status prüfen

```bash
sudo fail2ban-client status
sudo fail2ban-client status sshd
```
# Fertig und Weiter

Meine Admin-Skripte findet ihr hier: [github.com/picupup/scripts](https://github.com/picupup/scripts)

Nginx Proxy Manager: Schaut euch die [github.com/NginxProxyManager/nginx-proxy-manager](https://github.com/NginxProxyManager/nginx-proxy-manager) an. Damit habt ihr die Möglichkeit, eure Ports auf dem Server zu verwalten und nach außen mit einer Subdomain von eurem Domain freizugeben.
