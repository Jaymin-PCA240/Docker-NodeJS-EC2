import express from 'express';

const app = express();
const port = process.env.PORT || 3000;

app.get('/', (_req, res) => {
  res.send('Hello from TypeScript + Express from docker + CI/CD + ECS updated V2 Updated EC2!');
});

// Node.js example
app.get('/load', (req, res) => {
  const end = Date.now() + 10000;
  while (Date.now() < end) {}
  res.send("CPU load simulated");
});


app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
