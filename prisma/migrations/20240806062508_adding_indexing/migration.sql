/*
  Warnings:

  - You are about to alter the column `total_amount` on the `Billing` table. The data in that column could be lost. The data in that column will be cast from `DoublePrecision` to `Decimal(10,2)`.
  - You are about to alter the column `paid_amount` on the `Billing` table. The data in that column could be lost. The data in that column will be cast from `DoublePrecision` to `Decimal(10,2)`.
  - The primary key for the `Patients` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `name` on the `Patients` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.
  - You are about to alter the column `address` on the `Patients` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `phone_number_patients` on the `Patients` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(20)`.
  - The primary key for the `Reservations` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `doctor_id` on the `Reservations` table. All the data in the column will be lost.
  - You are about to alter the column `initial_visit_cost` on the `Reservations` table. The data in that column could be lost. The data in that column will be cast from `Integer` to `Decimal(10,2)`.
  - You are about to alter the column `total_cost` on the `Reservations` table. The data in that column could be lost. The data in that column will be cast from `DoublePrecision` to `Decimal(10,2)`.
  - You are about to alter the column `name` on the `Services` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.
  - You are about to alter the column `description` on the `Services` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(500)`.
  - You are about to alter the column `price` on the `Services` table. The data in that column could be lost. The data in that column will be cast from `DoublePrecision` to `Decimal(10,2)`.
  - You are about to alter the column `name` on the `Specializations` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.
  - You are about to alter the column `visit_price` on the `Specializations` table. The data in that column could be lost. The data in that column will be cast from `Integer` to `Decimal(10,2)`.
  - You are about to alter the column `visit_checking_price` on the `Specializations` table. The data in that column could be lost. The data in that column will be cast from `Integer` to `Decimal(10,2)`.
  - You are about to alter the column `description` on the `Specializations` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(500)`.
  - The primary key for the `Users` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `adminsId` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the column `doctorsId` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the column `employeesId` on the `Users` table. All the data in the column will be lost.
  - You are about to alter the column `name` on the `Users` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.
  - You are about to alter the column `email` on the `Users` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to drop the `Admins` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Doctors` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Employees` table. If the table is not empty, all the data it contains will be lost.
  - Changed the type of `gender` on the `Patients` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `status` on the `Reservations` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "StaffRole" AS ENUM ('DOCTOR', 'NURSE', 'RECEPTIONIST', 'ADMIN');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE');

-- CreateEnum
CREATE TYPE "ReservationStatus" AS ENUM ('SCHEDULED', 'CONFIRMED', 'CANCELLED', 'COMPLETED');

-- AlterEnum
ALTER TYPE "UserRole" ADD VALUE 'NURSE';

-- DropForeignKey
ALTER TABLE "Billing" DROP CONSTRAINT "Billing_patient_id_fkey";

-- DropForeignKey
ALTER TABLE "Billing" DROP CONSTRAINT "Billing_reservation_id_fkey";

-- DropForeignKey
ALTER TABLE "Doctors" DROP CONSTRAINT "Doctors_specialization_id_fkey";

-- DropForeignKey
ALTER TABLE "Reservation_Services" DROP CONSTRAINT "Reservation_Services_reservation_id_fkey";

-- DropForeignKey
ALTER TABLE "Reservations" DROP CONSTRAINT "Reservations_doctor_id_fkey";

-- DropForeignKey
ALTER TABLE "Reservations" DROP CONSTRAINT "Reservations_patient_id_fkey";

-- DropForeignKey
ALTER TABLE "Users" DROP CONSTRAINT "Users_adminsId_fkey";

-- DropForeignKey
ALTER TABLE "Users" DROP CONSTRAINT "Users_doctorsId_fkey";

-- DropForeignKey
ALTER TABLE "Users" DROP CONSTRAINT "Users_employeesId_fkey";

-- AlterTable
ALTER TABLE "Billing" ALTER COLUMN "patient_id" SET DATA TYPE TEXT,
ALTER COLUMN "reservation_id" SET DATA TYPE TEXT,
ALTER COLUMN "total_amount" SET DATA TYPE DECIMAL(10,2),
ALTER COLUMN "paid_amount" SET DATA TYPE DECIMAL(10,2),
ALTER COLUMN "billing_date" SET DATA TYPE DATE;

-- AlterTable
ALTER TABLE "Patients" DROP CONSTRAINT "Patients_pkey",
ADD COLUMN     "deleted_at" TIMESTAMP(3),
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "name" SET DATA TYPE VARCHAR(100),
DROP COLUMN "gender",
ADD COLUMN     "gender" "Gender" NOT NULL,
ALTER COLUMN "address" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "phone_number_patients" SET DATA TYPE VARCHAR(20),
ADD CONSTRAINT "Patients_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Patients_id_seq";

-- AlterTable
ALTER TABLE "Reservation_Services" ALTER COLUMN "reservation_id" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "Reservations" DROP CONSTRAINT "Reservations_pkey",
DROP COLUMN "doctor_id",
ADD COLUMN     "staff_id" TEXT,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "patient_id" SET DATA TYPE TEXT,
ALTER COLUMN "date" SET DATA TYPE DATE,
ALTER COLUMN "time" SET DATA TYPE TIME,
ALTER COLUMN "initial_visit_cost" SET DATA TYPE DECIMAL(10,2),
ALTER COLUMN "total_cost" SET DATA TYPE DECIMAL(10,2),
DROP COLUMN "status",
ADD COLUMN     "status" "ReservationStatus" NOT NULL,
ADD CONSTRAINT "Reservations_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Reservations_id_seq";

-- AlterTable
ALTER TABLE "Services" ALTER COLUMN "name" SET DATA TYPE VARCHAR(100),
ALTER COLUMN "description" SET DATA TYPE VARCHAR(500),
ALTER COLUMN "price" SET DATA TYPE DECIMAL(10,2);

-- AlterTable
ALTER TABLE "Specializations" ALTER COLUMN "name" SET DATA TYPE VARCHAR(100),
ALTER COLUMN "visit_price" SET DATA TYPE DECIMAL(10,2),
ALTER COLUMN "visit_checking_price" SET DATA TYPE DECIMAL(10,2),
ALTER COLUMN "description" SET DATA TYPE VARCHAR(500);

-- AlterTable
ALTER TABLE "Users" DROP CONSTRAINT "Users_pkey",
DROP COLUMN "adminsId",
DROP COLUMN "doctorsId",
DROP COLUMN "employeesId",
ADD COLUMN     "deleted_at" TIMESTAMP(3),
ADD COLUMN     "staffId" TEXT,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "name" SET DATA TYPE VARCHAR(100),
ALTER COLUMN "email" SET DATA TYPE VARCHAR(255),
ADD CONSTRAINT "Users_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Users_id_seq";

-- DropTable
DROP TABLE "Admins";

-- DropTable
DROP TABLE "Doctors";

-- DropTable
DROP TABLE "Employees";

-- CreateTable
CREATE TABLE "Staff" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" TEXT NOT NULL,
    "phone_number" VARCHAR(20) NOT NULL,
    "specialization_id" INTEGER,
    "percentage_per_visit" DECIMAL(5,2),
    "role" "StaffRole" NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "Staff_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Staff_email_key" ON "Staff"("email");

-- CreateIndex
CREATE INDEX "Staff_email_phone_number_idx" ON "Staff"("email", "phone_number");

-- CreateIndex
CREATE INDEX "Billing_billing_date_idx" ON "Billing"("billing_date");

-- CreateIndex
CREATE INDEX "Patients_phone_number_patients_idx" ON "Patients"("phone_number_patients");

-- CreateIndex
CREATE INDEX "Reservations_date_time_idx" ON "Reservations"("date", "time");

-- CreateIndex
CREATE INDEX "Services_name_idx" ON "Services"("name");

-- CreateIndex
CREATE INDEX "Specializations_name_idx" ON "Specializations"("name");

-- CreateIndex
CREATE INDEX "Users_email_idx" ON "Users"("email");

-- AddForeignKey
ALTER TABLE "Staff" ADD CONSTRAINT "Staff_specialization_id_fkey" FOREIGN KEY ("specialization_id") REFERENCES "Specializations"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservations" ADD CONSTRAINT "Reservations_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "Patients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservations" ADD CONSTRAINT "Reservations_staff_id_fkey" FOREIGN KEY ("staff_id") REFERENCES "Staff"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation_Services" ADD CONSTRAINT "Reservation_Services_reservation_id_fkey" FOREIGN KEY ("reservation_id") REFERENCES "Reservations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Billing" ADD CONSTRAINT "Billing_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "Patients"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Billing" ADD CONSTRAINT "Billing_reservation_id_fkey" FOREIGN KEY ("reservation_id") REFERENCES "Reservations"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Users" ADD CONSTRAINT "Users_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE SET NULL ON UPDATE CASCADE;
