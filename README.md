# Konnector School Management System

Konnector School is a role-based school management system built using **Ruby on Rails**.  
It supports **Admins**, **School Admins**, and **Students**, with both **UI-based workflows** and **JSON APIs**.

---

## Tech Stack

- Ruby 3.3.3
- Rails 7.1.6
- PostgreSQL
- Devise (Authentication)
- RSpec + FactoryBot (Testing)
- Bootstrap (Basic UI styling)

---

## Roles & Responsibilities

### Admin
- Manage schools
- Create and manage school admins

### School Admin
- Update school information
- Create and manage courses
- Create and manage batches
- Add students to the system
- Assign students to batches

### Student
- Login to the system
- View available batches
- Request enrollment
- View enrollment status
- View classmates after approval

---

## Application Features

### UI (HTML)
- Role-based dashboards
- CRUD operations for schools, courses, batches
- Student enrollment approval flow
- Batch-wise student management

### API (JSON – Versioned)
- Login API
- School admin APIs for courses, batches, students
- Student APIs for enrollments
- Clean RESTful structure (`/api/v1/...`)

---

## Project Setup

### 1. Clone the repository

git clone https://github.com/usharani12g/konnector_school.git

cd konnector_school

### 2. Install dependencies
bundle install

### 3. Database setup
rails db:create

rails db:migrate

rails db:seed

### 4. Start the server
rails s

Visit: http://localhost:3000

### Seeded Login Credentials
**Admin**

Email: admin@konnector.com

Password: test1234

**School Admin**

Email: schooladmin@konnector.com

Password: test1234

**Students**

student1@konnector.com / test1234

student2@konnector.com / test1234

### API Overview
**Base URL**

/api/v1

**Authentication**

POST /api/v1/auth/login

**School Admin APIs**

GET  /api/v1/school_admin/courses

POST /api/v1/school_admin/courses

GET  /api/v1/school_admin/batches

POST /api/v1/school_admin/batches

POST /api/v1/school_admin/batches/:id/assign_students

**Student APIs**

GET  /api/v1/student/enrollments

POST /api/v1/student/enrollments
