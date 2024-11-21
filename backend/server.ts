import { app } from "./app"

app
  .listen({ port: 3335 })
  .then(() => {
    console.log("HTTP Server Running on port 3335");
  })
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });