/*
  Warnings:

  - You are about to drop the column `precoUnitario` on the `cartitem` table. All the data in the column will be lost.
  - You are about to drop the column `quantidade` on the `cartitem` table. All the data in the column will be lost.
  - You are about to drop the column `nome` on the `category` table. All the data in the column will be lost.
  - You are about to drop the column `dataCriacao` on the `order` table. All the data in the column will be lost.
  - You are about to drop the column `dataPagamento` on the `order` table. All the data in the column will be lost.
  - You are about to drop the column `enderecoEnvio` on the `order` table. All the data in the column will be lost.
  - You are about to drop the column `precoUnitario` on the `orderitem` table. All the data in the column will be lost.
  - You are about to drop the column `quantidade` on the `orderitem` table. All the data in the column will be lost.
  - You are about to drop the column `categoriaId` on the `product` table. All the data in the column will be lost.
  - You are about to drop the column `descricao` on the `product` table. All the data in the column will be lost.
  - You are about to drop the column `estoque` on the `product` table. All the data in the column will be lost.
  - You are about to drop the column `imagemUrl` on the `product` table. All the data in the column will be lost.
  - You are about to drop the column `nome` on the `product` table. All the data in the column will be lost.
  - You are about to drop the column `preco` on the `product` table. All the data in the column will be lost.
  - You are about to drop the column `data` on the `stockmovement` table. All the data in the column will be lost.
  - You are about to drop the column `quantidade` on the `stockmovement` table. All the data in the column will be lost.
  - You are about to drop the column `tipo` on the `stockmovement` table. All the data in the column will be lost.
  - You are about to drop the column `dataCriacao` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `endereco` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `nome` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `senha` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `telefone` on the `user` table. All the data in the column will be lost.
  - Added the required column `quantity` to the `cartItem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `unitPrice` to the `cartItem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `category` table without a default value. This is not possible if the table is not empty.
  - Added the required column `quantity` to the `orderItem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `unitPrice` to the `orderItem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `categoryId` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `description` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `price` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `stock` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `quantity` to the `stockMovement` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `stockMovement` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `phone` to the `user` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `order` DROP FOREIGN KEY `Order_userId_fkey`;

-- DropForeignKey
ALTER TABLE `product` DROP FOREIGN KEY `Product_categoriaId_fkey`;

-- AlterTable
ALTER TABLE `cartitem` DROP COLUMN `precoUnitario`,
    DROP COLUMN `quantidade`,
    ADD COLUMN `quantity` INTEGER NOT NULL,
    ADD COLUMN `unitPrice` DOUBLE NOT NULL;

-- AlterTable
ALTER TABLE `category` DROP COLUMN `nome`,
    ADD COLUMN `name` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `order` DROP COLUMN `dataCriacao`,
    DROP COLUMN `dataPagamento`,
    DROP COLUMN `enderecoEnvio`,
    ADD COLUMN `creationDate` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `paymentDate` DATETIME(3) NULL,
    ADD COLUMN `shippingAddressId` INTEGER NULL;

-- AlterTable
ALTER TABLE `orderitem` DROP COLUMN `precoUnitario`,
    DROP COLUMN `quantidade`,
    ADD COLUMN `quantity` INTEGER NOT NULL,
    ADD COLUMN `unitPrice` DOUBLE NOT NULL;

-- AlterTable
ALTER TABLE `product` DROP COLUMN `categoriaId`,
    DROP COLUMN `descricao`,
    DROP COLUMN `estoque`,
    DROP COLUMN `imagemUrl`,
    DROP COLUMN `nome`,
    DROP COLUMN `preco`,
    ADD COLUMN `categoryId` INTEGER NOT NULL,
    ADD COLUMN `description` VARCHAR(191) NOT NULL,
    ADD COLUMN `imageUrl` VARCHAR(191) NULL,
    ADD COLUMN `name` VARCHAR(191) NOT NULL,
    ADD COLUMN `price` DOUBLE NOT NULL,
    ADD COLUMN `stock` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `stockmovement` DROP COLUMN `data`,
    DROP COLUMN `quantidade`,
    DROP COLUMN `tipo`,
    ADD COLUMN `date` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `quantity` INTEGER NOT NULL,
    ADD COLUMN `type` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `user` DROP COLUMN `dataCriacao`,
    DROP COLUMN `endereco`,
    DROP COLUMN `nome`,
    DROP COLUMN `senha`,
    DROP COLUMN `telefone`,
    ADD COLUMN `addressId` INTEGER NULL,
    ADD COLUMN `creationDate` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `name` VARCHAR(191) NOT NULL,
    ADD COLUMN `password` VARCHAR(191) NOT NULL,
    ADD COLUMN `phone` VARCHAR(191) NOT NULL;

-- CreateTable
CREATE TABLE `address` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `street` VARCHAR(191) NOT NULL,
    `neighborhood` VARCHAR(191) NOT NULL,
    `number` VARCHAR(191) NOT NULL,
    `city` VARCHAR(191) NOT NULL,
    `state` VARCHAR(191) NOT NULL,
    `zipCode` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE INDEX `Product_categoryId_fkey` ON `product`(`categoryId`);

-- AddForeignKey
ALTER TABLE `order` ADD CONSTRAINT `order_shippingAddressId_fkey` FOREIGN KEY (`shippingAddressId`) REFERENCES `address`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `order` ADD CONSTRAINT `order_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product` ADD CONSTRAINT `Product_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `category`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user` ADD CONSTRAINT `User_addressId_fkey` FOREIGN KEY (`addressId`) REFERENCES `address`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- RenameIndex
ALTER TABLE `order` RENAME INDEX `Order_userId_fkey` TO `order_userId_idx`;
