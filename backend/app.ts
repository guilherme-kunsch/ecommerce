import fastify from 'fastify'
import { createUser, validationUser } from './controllers/userController';

export const app = fastify();

app.addHook('preHandler', async (request) => {
    console.log(`[${request.method}] ${request.url}`)
})

app.post("/user", createUser)
app.post("/user/validationUser", validationUser)