import { PrismaClient } from "@prisma/client";
import { z } from "zod";
import bcrypt, { hash } from "bcrypt";
import { FastifyReply, FastifyRequest } from "fastify";

const prisma = new PrismaClient();

export const createUserSchema = z.object({
  nome: z.string().min(1, "Nome é obrigatório"),
  email: z.string().email("E-mail inválido"),
  senha: z.string().min(6, "A senha deve ter pelo menos 6 caracteres"),
  endereco: z.string().optional(),
  telefone: z.string().regex(/^\d+$/, "Telefone deve conter apenas números"),
});

export const validateAndFindUser = z.object({
  email: z.string().email("E-mail inválido"),
  senha: z.string().min(6, "A senha deve ter pelo menos 6 caracteres")
})

export const hashPassword = async (password: string) => {
  const salt = await bcrypt.genSalt(10);
  return bcrypt.hash(password, salt);
};

export const userService = {
  createUser: async (input: z.infer<typeof createUserSchema>) => {
    const parsedInput = createUserSchema.parse(input);

    const userExists = await prisma.user.findUnique({
      where: { email: parsedInput.email },
    });

    if (userExists) {
      throw new Error("E-mail já está em uso");
    }

    const hashedPassword = await hashPassword(parsedInput.senha);

    const newUser = await prisma.user.create({
      data: {
        ...parsedInput,
        senha: hashedPassword,
      },
    });

    return newUser;
  },

  loginUser: async (input: z.infer<typeof validateAndFindUser>) => {
    const parsedInput = validateAndFindUser.parse(input)

    const user = await prisma.user.findUnique({
      where: {
        email: parsedInput.email
      }
    })

    if (!user) {
      throw new Error("E-mail ou senha incorretos");
    }

    const isPasswordValid = await bcrypt.compare(parsedInput.senha, user.senha);
    if (!isPasswordValid) {
      throw new Error("E-mail ou senha incorretos");
    }

    return {
      message: "Login realizado com sucesso!",
      userId: user.id,
      email: user.email,
    };
  },
};
