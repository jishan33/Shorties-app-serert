user_1 = User.create(email: "1@g.com", password: "123", is_teacher: true, username: "Alice")

user_2 = User.create(email: "2@g.com", password: "123", username: "Harry")

user_3 = User.create(email: "3@g.com", password: "123", username: "Sam")


cohort_1 = Cohort.create(name: "Rails", user_id: user_1.id) 

cohort_user_1 = UserCohort.create(cohort_id: cohort_1.id, user_id: user_2.id)

cohort_user_2 = UserCohort.create(cohort_id: cohort_1.id, user_id: user_3.id)


note_1 = Note.create(user_id: user_2.id, title: "ruby-array")

category_1 = Category.create(name: "JavaScript")

category_note = CategoryNote.create(category_id: category_1.id, note_id: note_1.id)