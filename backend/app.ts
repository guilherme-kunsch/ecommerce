import fastify from 'fastify'
import { createUser, validationUser } from './controllers/userController';
import fastifyCors from '@fastify/cors';

export const app = fastify();

app.addHook('preHandler', async (request) => {
    console.log(`[${request.method}] ${request.url}`);
});

app.register(fastifyCors, {
    origin: 'http://localhost:5173', 
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    credentials: true, 
});

app.post("/user", createUser);
app.post("/user/validationUser", validationUser);
