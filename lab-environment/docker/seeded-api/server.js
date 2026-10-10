// server.js — illustrative seed app for a LAB target only.
// Deliberately vulnerable by design (training target), never deploy outside an isolated lab.
const express = require('express');
const jwt = require('jsonwebtoken');
const app = express();
app.use(express.json());

const orders = { 1: { owner: 'alice' }, 2: { owner: 'bob' }, 3: { owner: 'carol' } };

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
  const authHeader = req.headers.authorization || '';
  const token = authHeader.split(' ')[1];
  const decoded = token ? jwt.decode(token, { complete: true }) : null;
  // VULNERABLE: trusts the header-declared alg instead of enforcing one server-side
  if (decoded?.header?.alg === 'none') {
    return res.json({ user: decoded.payload.user, note: 'alg:none accepted' });
  }
  res.sendStatus(401);
});

app.listen(4000, () => console.log('seeded-api on :4000'));
