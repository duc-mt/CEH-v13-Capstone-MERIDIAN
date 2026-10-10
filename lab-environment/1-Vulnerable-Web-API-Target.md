# Vulnerable Web/API Target — Juice Shop + Seeded API

Reproduces `portal.meridiandynamics-corp.com` / `api.meridiandynamics-corp.com` (DMZ/VLAN20) for Module 11, 13, 14, 15, and 17 using [OWASP Juice Shop](https://github.com/juice-shop/juice-shop) for the SPA/session layer and a small seeded Node/Express API for the IDOR/JWT/GraphQL-specific findings Juice Shop doesn't natively cover.

## docker-compose.yml
The full, CI-validated files live at [`docker/docker-compose.yml`](docker/docker-compose.yml) and [`docker/seeded-api/`](docker/seeded-api/) — excerpts below.
```yaml
version: "3.8"
services:
  juice-shop:
    image: bkimminich/juice-shop:latest
    ports: ["3000:3000"]
    networks: [dmz-lab]

  seeded-api:
    build: ./seeded-api
    ports: ["4000:4000"]
    environment:
      - JWT_ALG_NONE_ALLOWED=true   # reproduces F-12
      - RATE_LIMIT_DISABLED=true    # reproduces API8 finding
    networks: [dmz-lab]

networks:
  dmz-lab:
    driver: bridge
```

## seeded-api — Minimal Express App Reproducing This Project's Findings
```js
// server.js — illustrative seed app for a LAB target only.
// Deliberately vulnerable by design (training target), never deploy outside an isolated lab.
const express = require('express');
const jwt = require('jsonwebtoken');
const app = express();
app.use(express.json());

const orders = { 1: {owner:'alice'}, 2: {owner:'bob'}, 3: {owner:'carol'} };

// F-11: IDOR — no ownership check
app.get('/v2/orders/:id', (req, res) => {
  const order = orders[req.params.id];
  order ? res.json(order) : res.sendStatus(404);
});

// F-12: JWT alg:none acceptance (lab-only demonstration of the vulnerable pattern)
app.post('/v2/login', (req, res) => {
  const token = jwt.sign({ user: req.body.user }, 'lab-secret', { algorithm: 'HS256' });
  res.json({ token });
});
app.get('/v2/me', (req, res) => {
  const decoded = jwt.decode(req.headers.authorization?.split(' ')[1], { complete: true });
  // VULNERABLE: trusts the header-declared alg instead of enforcing one server-side
  if (decoded?.header?.alg === 'none') return res.json({ user: decoded.payload.user, note: 'alg:none accepted' });
  res.sendStatus(401);
});

app.listen(4000, () => console.log('seeded-api on :4000'));
```

## Bringing It Up
```bash
cd docker/
docker compose up -d
curl http://localhost:4000/v2/orders/2       # reproduces Module15/Module14 IDOR testing
# then re-run the sqlmap/ffuf/Burp workflows from Module13-15 against localhost:3000 / :4000
```

## Resetting
```bash
docker compose down -v && docker compose up -d
```

CI (`.github/workflows/docker-validate.yml`) runs `docker compose config` and a Dockerfile lint on every change under `docker/` — it never starts the containers in CI.
