import { FastifyReply, FastifyRequest } from "fastify";
import { createUserSchema, userService, validateAndFindUser } from "../services/userService";
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

export const validationUser = async(
  request: FastifyRequest<{Body: z.infer<typeof validateAndFindUser>}>,
  reply: FastifyReply
): Promise<void> => {
  try {
    const body = request.body;
    const validationPassword = await userService.loginUser(body);

    return reply.code(200).send({
      message: 'Acessando...',
    });
  } catch (err: any) {
    reply
      .code(err.statusCode || 400)
      .send({ error: err.message || 'Erro ao autenticar o usuário' });
  }
}