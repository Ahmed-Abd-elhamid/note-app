require 'faker'

def create_user(email, password)
    user = User.create!(
        email: email,
        password: password,
    )
end

def create_notes_collaborations
    rand(10..14).times do |t1|
        user_id = User.all.sample.id
        note = Note.create!(
            uuid: SecureRandom.uuid,
            password: Faker::Internet.password,
            title: Faker::Game.title,
            body: Faker::Lorem.paragraph,
            user_id: user_id
        )
        can_edit = Faker::Boolean.boolean(true_ratio: 0.65)
        rand(2..4).times do |t2|
            Collaboration.create!(
                note_id: note.id,
                user_id: User.where.not(id: note.user.id).last.id + t2,
                can_edit: can_edit
            )
        end
    end
end


create_user("ahmed@mail.com", "123456")
create_user("test@mail.com", "123456")

5.times do |t|
    create_user(Faker::Internet.email, "123456")
end

create_notes_collaborations