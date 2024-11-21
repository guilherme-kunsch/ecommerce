import { PrismaClient } from "@prisma/client";
import { z } from "zod";
import bcrypt, { hash } from "bcrypt";
import { FastifyReply, FastifyRequest } from "fastify";

const prisma = new PrismaClient();

export const createUserSchema = z.object({
  name: z.string().min(1, "Name is required"), 
  email: z.string().email("Invalid email"),
  password: z.string().min(6, "Password must be at least 6 characters long"),
  phone: z.string().min(10, "Phone must have at least 10 digits"),
  address: z.object({
    street: z.string().min(1, "Street is required"),
    neighborhood: z.string().min(1, "Neighborhood is required"),
    number: z.string().min(1, "Number is required"),
    city: z.string().min(1, "City is required"),
    state: z.string().min(2, "State is required"), 
    zipCode: z.string().min(5, "Zip code must be at least 5 characters"),
  })
});

export const validateAndFindUser = z.object({
  email: z.string().email("Invalid email"),
  password: z.string().min(6, "Password must be at least 6 characters long")
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

    const hashedPassword = await hashPassword(parsedInput.password);

    const newUser = await prisma.user.create({
      data: {
        ...parsedInput,
        password: hashedPassword,
        address: {
          create: {
            ...parsedInput.address,
          }
        }
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
      throw new Error("Incorrect email or password");
    }

    const isPasswordValid = await bcrypt.compare(parsedInput.password, user.password);
    if (!isPasswordValid) {
      throw new Error("Incorrect email or password");
    }

    return {
      message: "Login successfully!",
      userId: user.id,
      email: user.email,
    };
  },
};
