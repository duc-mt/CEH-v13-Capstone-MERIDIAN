# IoT Protocol Deep-Dive: MQTT, CoAP, ZigBee (v13 addition)

Complements `0-IoT.md` (IP cameras, badge readers) with the lighter-weight IoT protocols used by MDX's warehouse sensor fleet.

| Protocol | Device class | Test | Result |
| --- | --- | --- | --- |
| MQTT | Warehouse temperature/humidity sensors | Unauthenticated broker connection attempt (`mosquitto_sub` against port 1883) | Broker allows anonymous subscribe to all topics — **F-38**, sensor telemetry (including door-sensor open/close events) readable by anyone on the warehouse VLAN |
| CoAP | Loading-dock proximity sensors | `coap-client` GET against discovered resource paths | No DTLS in use — plaintext CoAP, readable by passive observer on the same segment — **F-39** |
| ZigBee | Badge-adjacent environmental sensors | Passive sniffing of ZigBee traffic (`Zigbee2MQTT`-class tooling, read-only) | Network key observed in cleartext during pairing capture (replay-vulnerable pairing window) — **F-40** |

## Findings

- **F-38 (Medium)** — Anonymous MQTT broker access exposes operational telemetry (including door-sensor state, which is physical-security-adjacent) without authentication.
- **F-39 (Medium)** — CoAP sensors transmit without DTLS; low business impact alone, but compounds F-38 as part of a broader "IoT segment has no transport security" pattern.
- **F-40 (Medium)** — ZigBee network key exposure during pairing allows traffic decryption for anyone who captured that pairing window.

## Detection Logic

```yaml
title: Anonymous MQTT Broker Subscribe
logsource: {category: network_traffic}
detection:
  selection:
    dst_port: 1883
    mqtt_connect_flags.username_present: false
  condition: selection
level: medium
tags: [attack.collection, attack.t1557]
```
