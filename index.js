process.on("uncaughtException", error => {
  console.error("[Root Startup] Uncaught exception:", error);
});

process.on("unhandledRejection", error => {
  console.error("[Root Startup] Unhandled rejection:", error);
});

console.log("[Root Startup] Loading hostinger runtime bundle");

import("./hostinger-deploy/index.js").catch(error => {
  console.error("[Root Startup] Failed to load hostinger runtime bundle:", error);
  process.exitCode = 1;
});
