const express = require("express");
const Prometheus = require("prom-client");

const app = express();
const port = process.env.PORT || 3001;
const metricsInterval = Prometheus.collectDefaultMetrics();
const checkoutsTotal = new Prometheus.Counter({
  name: "checkouts_total",
  help: "Total number of checkouts",
  labelNames: ["payment_method"],
});
const httpRequestDurationMicroseconds = new Prometheus.Histogram({
  name: "http_request_duration_ms",
  help: "Duration of HTTP requests in ms",
  labelNames: ["method", "route", "code"],
  buckets: [0.1, 5, 15, 50, 100, 200, 300, 400, 500], // buckets for response time from 0.1ms to 500ms
});

const loginCounter = new client.Counter({
  name: "login_counter",
  help: "Number of times the exporter has logged in to parquet",
  labelNames: ["parquet", "money"],
});

const portfolioCounter = new client.Gauge({
  name: "portfolio_value",
  help: "Total value of the portfolio",
  labelNames: ["parquet", "money"],
});

const investedCounter = new client.Gauge({
  name: "invested_value",
  help: "Total value invested",
  labelNames: ["parquet", "money"],
});

const portfolioWinCounter = new client.Gauge({
  name: "win_value",
  help: "Total win of the portfolio",
  labelNames: ["parquet", "money"],
});

const dividendCounter = new client.Gauge({
  name: "dividend_value",
  help: "received dividends",
  labelNames: ["parquet", "money"],
});

const fetch_time = new Prometheus.Histogram({
  name: "fetch_time",
  help: "total time to fetch ",
  labelNames: ["parquet", "money"],
  buckets: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50], // buckets for response time from 0.1ms to 500ms
});

// Runs before each requests
app.use((req, res, next) => {
  res.locals.startEpoch = Date.now();
  next();
});

app.get("/", (req, res, next) => {
  setTimeout(() => {
    res.json({ message: "Hello World!" });
    next();
  }, Math.round(Math.random() * 200));
});

app.get("/bad", (req, res, next) => {
  next(new Error("My Error"));
});

app.get("/checkout", (req, res, next) => {
  const paymentMethod = Math.round(Math.random()) === 0 ? "stripe" : "paypal";

  checkoutsTotal.inc({
    payment_method: paymentMethod,
  });

  res.json({ status: "ok" });
  next();
});

app.get("/metrics", async (req, res) => {
  console.log("data");
  res.set("Content-Type", Prometheus.register.contentType);
  let data = await Prometheus.register.metrics();
  res.end(data);
});

// Error handler
app.use((err, req, res, next) => {
  res.statusCode = 500;
  // Do not expose your error in production
  res.json({ error: err.message });
  next();
});

// Runs after each requests
app.use((req, res, next) => {
  const responseTimeInMs = Date.now() - res.locals.startEpoch;

  httpRequestDurationMicroseconds
    .labels(req.method, req.route.path, res.statusCode)
    .observe(responseTimeInMs);

  next();
});

const server = app.listen(port, () => {
  console.log(`Example app listening on port ${port}!`);
});

// Graceful shutdown
process.on("SIGTERM", () => {
  clearInterval(metricsInterval);

  server.close((err) => {
    if (err) {
      console.error(err);
      process.exit(1);
    }

    process.exit(0);
  });
});
