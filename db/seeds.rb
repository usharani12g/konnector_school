admin = User.create!(
  email: "admin@konnector.com",
  password: "test1234",
  role: :admin
)

school = School.create!(
  name: "Konnector School",
  address: "Bangalore"
)

school_admin = User.create!(
  email: "schooladmin@konnector.com",
  password: "test1234",
  role: :school_admin,
  school: school
)

student1 = User.create!(
  email: "student1@konnector.com",
  password: "test1234",
  role: :student,
  school: school
)

student2 = User.create!(
  email: "student2@konnector.com",
  password: "test1234",
  role: :student,
  school: school
)

course1 = Course.create!(
  name: "BE",
  school: school
)

course2 = Course.create!(
  name: "MCA",
  school: school
)

batch = Batch.create!(
  name: "Batch A",
  course: course1
)

batch = Batch.create!(
  name: "Batch B",
  course: course2
)

