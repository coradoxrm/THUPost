# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(email: "dev@mails.tsinghua.edu.cn",
                    phone: "11111111111",
                    nickname: "test",
                    password: "12345678",
                    confirmed_at:DateTime.now
                    )
user.skip_confirmation!
