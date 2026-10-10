# OT/ICS Simulator — ModbusPal / OpenPLC (Simulation Mode)

Reproduces the historian/HMI (10.40.5.20, VLAN50, Purdue Level 2–3) for Module18, **without ever touching real PLCs/sensors** — the read-only boundary from `topology/0-Network-Topology.md` is enforced by construction here: the simulator has no Level 0/1 devices attached at all.

## Option A — ModbusPal (quick, read-only tag simulation)
```bash
# Requires Java
wget https://sourceforge.net/projects/modbuspal/files/latest/download -O modbuspal.jar
java -jar modbuspal.jar
# In the GUI: Add Slave -> set unit ID -> add holding registers to simulate historian tags
# (e.g. "Tank_Level_1", "Line_Speed_1") -> Start the simulator on port 502
```

## Option B — OpenPLC (simulation mode, closer to a real HMI/PLC split)
```bash
git clone https://github.com/thiagoralves/OpenPLC_v3.git
cd OpenPLC_v3 && ./install.sh linux
./start_openplc.sh
# Web UI on :8080 -> upload a sample ladder-logic program in SIMULATION mode only
# (Settings -> Enable Modbus Server, port 502) — no physical I/O is ever wired
```

## Reproducing F-21 (Unauthenticated Modbus Read)
```bash
# Passive read-only enumeration, matching Module18's documented technique
mbtget -r4 -a1 -n10 <simulator-ip>
```
No function codes beyond read (0x03/0x04) should ever be issued against this simulator either — the point of the lab is to validate the *detection* of unauthorized reads (`10-Detection-Engineering/sigma-rules/11-unauthorized-modbus-read.yml`), not to practice writes.

## Network Placement
Run the simulator on its own isolated VLAN/host-only network, segmented from the AD lab (`0-AD-Lab-GOAD-Setup.md`) the same way VLAN50 is segmented from VLAN10/20/40 in `../topology/0-Network-Topology.md` — the point is to validate that your lab's segmentation controls (or lack of them) match what you're documenting.
