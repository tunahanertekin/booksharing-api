

User.all.each do |item|
    7.times do
        Book.create(
            {
                title: Faker::Book.title,
                author: Faker::Book.author,
                price: Faker::Number.decimal(l_digits: 1, r_digits: 1),
                user_id: Faker::Number.number(digits: 1)
            }
        )
    end
end