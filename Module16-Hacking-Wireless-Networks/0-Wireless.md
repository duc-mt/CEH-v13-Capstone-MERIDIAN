# Wireless (WPA2/3-Enterprise)

| Test | Tool class | Result |
| --- | --- | --- |
| Rogue AP / Evil Twin against `MDX-Guest` | hostapd-based rogue AP | 6 of 20 test devices auto-connected — **F-17** |
| WPA2-Enterprise handshake capture + offline analysis | aircrack-ng-class suite | EAP-PEAP with weak client cert validation — MITM feasible — **F-18** |
| Guest → Corp VLAN hop | 802.1Q double-tagging test | Blocked correctly — pass |
