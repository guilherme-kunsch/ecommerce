import { FastifyReply, FastifyRequest } from "fastify";
import { createUserSchema, userService } from "../services/userService";
import { z } from "zod";

export const createUser = async (
  request: FastifyRequest<{ Body: z.infer<typeof createUserSchema> }>, 
  reply: FastifyReply
): Promise<void> => {
  try {
    const body = request.body;
    const newUser = await userService.createUser(body);

    return reply.status(201).send({
      message: "Usuário criado com sucesso",
      newUser
    });
  } catch (err: any) {
    reply.code(err.statusCode || 500).send({ error: err.message });
  }
};
