# SSH-Zugang einrichten
Für die Bearbeitung der Schritte musst du dich mit einem „remote-server“ verbinden.\
**Nutzernummer/port**: Für deinen Nutzer wähle bitte ein Server ([Auch verfügbar in paired\_ports.txt](https://github.com/picupup/debian-workshop-2024/blob/main/doc/paired_ports.txt)):

```txt
Server	:	Port 1	-	Port 2
#Port>
1	:	20000	-	20001
2	:	20003	-	20007
3	:	20009	-	20019
4	:	20020	-	20026
5	:	20041	-	20044
6	:	20045	-	20052
7	:	20059	-	20062
8	:	20069	-	20078
9	:	20081	-	20090
10	:	20097	-	20098
11	:	20105	-	20111
12	:	20112	-	20124
13	:	20129	-	20135
14	:	20140	-	20148
15	:	20154	-	20159
16	:	20174	-	20179
17	:	20181	-	20185
18	:	20189	-	20196
19	:	20206	-	20212
20	:	20226	-	20235
21	:	20237	-	20243
22	:	20244	-	20254
23	:	20262	-	20279
24	:	20280	-	20286
25	:	20296	-	20303
26	:	20309	-	20315
27	:	20317	-	20327
28	:	20334	-	20340
29	:	20347	-	20371
30	:	20377	-	20379
31	:	20386	-	20396
32	:	20398	-	20406
33	:	20411	-	20416
34	:	20418	-	20422
35	:	20432	-	20434
36	:	20442	-	20448
37	:	20449	-	20453
38	:	20463	-	20469
39	:	20472	-	20484
40	:	20490	-	20497
41	:	20500	-	20507
42	:	20512	-	20517
43	:	20519	-	20527
44	:	20530	-	20544
45	:	20553	-	20556
46	:	20562	-	20572
47	:	20578	-	20589
48	:	20594	-	20599
49	:	20607	-	20614
50	:	20630	-	20642
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

