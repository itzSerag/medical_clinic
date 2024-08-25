/*
  Warnings:

  - The values [DOCTOR] on the enum `StaffRole` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `billing_date` on the `Billing` table. All the data in the column will be lost.
  - You are about to drop the column `paid_amount` on the `Billing` table. All the data in the column will be lost.
  - You are about to drop the column `patient_id` on the `Billing` table. All the data in the column will be lost.
  - You are about to drop the column `reservation_id` on the `Billing` table. All the data in the column will be lost.
  - You are about to drop the column `total_amount` on the `Billing` table. All the data in the column will be lost.
  - You are about to drop the column `deleted_at` on the `Patients` table. All the data in the column will be lost.
  - You are about to drop the column `phone_number_patients` on the `Patients` table. All the data in the column will be lost.
  - You are about to drop the column `initial_visit_cost` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `patient_id` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `specialization_id` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `staff_id` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `total_cost` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `specialization_id` on the `Services` table. All the data in the column will be lost.
  - You are about to drop the column `visit_checking_price` on the `Specializations` table. All the data in the column will be lost.
  - You are about to drop the column `visit_price` on the `Specializations` table. All the data in the column will be lost.
  - You are about to drop the column `deleted_at` on the `Staff` table. All the data in the column will be lost.
  - You are about to drop the column `percentage_per_visit` on the `Staff` table. All the data in the column will be lost.
  - You are about to drop the column `phone_number` on the `Staff` table. All the data in the column will be lost.
  - You are about to drop the column `specialization_id` on the `Staff` table. All the data in the column will be lost.
  - You are about to drop the `Reservation_Services` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Users` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `billingDate` to the `Billing` table without a default value. This is not possible if the table is not empty.
  - Added the required column `phoneNumberPatients` to the `Patients` table without a default value. This is not possible if the table is not empty.
  - Added the required column `initialVisitCost` to the `Reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `patientId` to the `Reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `specializationId` to the `Reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `specializationId` to the `Services` table without a default value. This is not possible if the table is not empty.
  - Added the required column `visitCheckingPrice` to the `Specializations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `visitPrice` to the `Specializations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `phoneNumber` to the `Staff` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "StaffRole_new" AS ENUM ('NURSE', 'RECEPTIONIST', 'ADMIN');
ALTER TABLE "Staff" ALTER COLUMN "role" TYPE "StaffRole_new" USING ("role"::text::"StaffRole_new");
ALTER TYPE "StaffRole" RENAME TO "StaffRole_old";
ALTER TYPE "StaffRole_new" RENAME TO "StaffRole";
DROP TYPE "StaffRole_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "Billing" DROP CONSTRAINT "Billing_patient_id_fkey";

-- DropForeignKey
ALTER TABLE "Billing" DROP CONSTRAINT "Billing_reservation_id_fkey";

-- DropForeignKey
ALTER TABLE "Reservation_Services" DROP CONSTRAINT "Reservation_Services_reservation_id_fkey";

-- DropForeignKey
ALTER TABLE "Reservation_Services" DROP CONSTRAINT "Reservation_Services_service_id_fkey";

-- DropForeignKey
ALTER TABLE "Reservations" DROP CONSTRAINT "Reservations_patient_id_fkey";

-- DropForeignKey
ALTER TABLE "Reservations" DROP CONSTRAINT "Reservations_specialization_id_fkey";

-- DropForeignKey
ALTER TABLE "Reservations" DROP CONSTRAINT "Reservations_staff_id_fkey";

-- DropForeignKey
ALTER TABLE "Services" DROP CONSTRAINT "Services_specialization_id_fkey";

-- DropForeignKey
ALTER TABLE "Staff" DROP CONSTRAINT "Staff_specialization_id_fkey";

-- DropForeignKey
ALTER TABLE "Users" DROP CONSTRAINT "Users_staffId_fkey";

-- DropIndex
DROP INDEX "Billing_billing_date_idx";

-- DropIndex
DROP INDEX "Patients_phone_number_patients_idx";

-- DropIndex
DROP INDEX "Staff_email_phone_number_idx";

-- AlterTable
ALTER TABLE "Billing" DROP COLUMN "billing_date",
DROP COLUMN "paid_amount",
DROP COLUMN "patient_id",
DROP COLUMN "reservation_id",
DROP COLUMN "total_amount",
ADD COLUMN     "billingDate" DATE NOT NULL,
ADD COLUMN     "paidAmount" DECIMAL(10,2),
ADD COLUMN     "patientId" TEXT,
ADD COLUMN     "reservationId" TEXT,
ADD COLUMN     "totalAmount" DECIMAL(10,2);

-- AlterTable
ALTER TABLE "Patients" DROP COLUMN "deleted_at",
DROP COLUMN "phone_number_patients",
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "phoneNumberPatients" VARCHAR(20) NOT NULL;

-- AlterTable
ALTER TABLE "Reservations" DROP COLUMN "initial_visit_cost",
DROP COLUMN "patient_id",
DROP COLUMN "specialization_id",
DROP COLUMN "staff_id",
DROP COLUMN "total_cost",
ADD COLUMN     "doctorId" TEXT,
ADD COLUMN     "initialVisitCost" DECIMAL(10,2) NOT NULL,
ADD COLUMN     "patientId" TEXT NOT NULL,
ADD COLUMN     "specializationId" INTEGER NOT NULL,
ADD COLUMN     "staffId" TEXT,
ADD COLUMN     "totalCost" DECIMAL(10,2);

-- AlterTable
ALTER TABLE "Services" DROP COLUMN "specialization_id",
ADD COLUMN     "specializationId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Specializations" DROP COLUMN "visit_checking_price",
DROP COLUMN "visit_price",
ADD COLUMN     "visitCheckingPrice" DECIMAL(10,2) NOT NULL,
ADD COLUMN     "visitPrice" DECIMAL(10,2) NOT NULL;

-- AlterTable
ALTER TABLE "Staff" DROP COLUMN "deleted_at",
DROP COLUMN "percentage_per_visit",
DROP COLUMN "phone_number",
DROP COLUMN "specialization_id",
ADD COLUMN     "phoneNumber" VARCHAR(20) NOT NULL;

-- DropTable
DROP TABLE "Reservation_Services";

-- DropTable
DROP TABLE "Users";

-- DropEnum
DROP TYPE "UserRole";

-- CreateTable
CREATE TABLE "Doctor" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" TEXT NOT NULL,
    "phoneNumber" VARCHAR(20) NOT NULL,
    "specializationId" INTEGER NOT NULL,
    "percentagePerVisit" DECIMAL(5,2),

    CONSTRAINT "Doctor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReservationServices" (
    "id" SERIAL NOT NULL,
    "reservationId" TEXT NOT NULL,
    "serviceId" INTEGER,

    CONSTRAINT "ReservationServices_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Doctor_email_key" ON "Doctor"("email");

-- CreateIndex
CREATE INDEX "Doctor_email_phoneNumber_idx" ON "Doctor"("email", "phoneNumber");

-- CreateIndex
CREATE INDEX "Billing_billingDate_idx" ON "Billing"("billingDate");

-- CreateIndex
CREATE INDEX "Patients_phoneNumberPatients_idx" ON "Patients"("phoneNumberPatients");

-- CreateIndex
CREATE INDEX "Staff_email_phoneNumber_idx" ON "Staff"("email", "phoneNumber");

-- AddForeignKey
ALTER TABLE "Doctor" ADD CONSTRAINT "Doctor_specializationId_fkey" FOREIGN KEY ("specializationId") REFERENCES "Specializations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Services" ADD CONSTRAINT "Services_specializationId_fkey" FOREIGN KEY ("specializationId") REFERENCES "Specializations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservations" ADD CONSTRAINT "Reservations_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservations" ADD CONSTRAINT "Reservations_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservations" ADD CONSTRAINT "Reservations_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "Doctor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservations" ADD CONSTRAINT "Reservations_specializationId_fkey" FOREIGN KEY ("specializationId") REFERENCES "Specializations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReservationServices" ADD CONSTRAINT "ReservationServices_reservationId_fkey" FOREIGN KEY ("reservationId") REFERENCES "Reservations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReservationServices" ADD CONSTRAINT "ReservationServices_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Services"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Billing" ADD CONSTRAINT "Billing_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patients"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Billing" ADD CONSTRAINT "Billing_reservationId_fkey" FOREIGN KEY ("reservationId") REFERENCES "Reservations"("id") ON DELETE SET NULL ON UPDATE CASCADE;
