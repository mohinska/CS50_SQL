CREATE INDEX "enrollments_student_id"
ON "enrollments"("student_id");

CREATE INDEX "enrollments_course_id"
ON "enrollments"("course_id");

CREATE INDEX "courses_department"
ON "courses"("department");

CREATE INDEX "courses_title"
ON "courses"("title");

CREATE INDEX "courses_number"
ON "courses"("number");

CREATE INDEX "courses_semester"
ON "courses"("semester");
