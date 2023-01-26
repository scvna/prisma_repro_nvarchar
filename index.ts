import { PrismaClient } from "@prisma/client";

const createdAt = (): Date => new Date();

type UpsertFileInput = {
  url: string;
  photographerUserId: number;
};
const upsertFile = async (
  prisma: PrismaClient,
  { url, photographerUserId }: UpsertFileInput
): Promise<Number> => {
  const { FileId, UpdatedAt } = await prisma.file.upsert({
    where: {
      Url: url,
    },
    create: {
      PhotographerUserId: photographerUserId,
      CreatedAt: createdAt(),
    },
    update: {},
    select: {
      FileId: true,
      UpdatedAt: true,
    },
  });

  return FileId;
};

const run = async () => {
  const prisma = new PrismaClient();

  const user = await prisma.user.upsert({
    where: {
      Email: "prisma@repro.com",
    },
    create: {
      Email: "prisma@repro.com",
      Name: "Hello",
      CreatedAt: createdAt(),
    },
    update: {},
  });
  console.log(`upserted user ${JSON.stringify(user)}`);

  const fileId = await upsertFile(prisma, {
    url: "https://google.com",
    photographerUserId: user.UserId,
  });
  console.log(`upserted file with id ${fileId}`);
};

try {
  run();
} catch (e) {
  console.log("run failed");
  console.log("run failed");
  console.log("run failed");
  console.log("run failed");
  console.log(e);
}
