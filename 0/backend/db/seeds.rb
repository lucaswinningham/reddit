users = 4.times.map { FactoryBot.create :user }
reddit_user = FactoryBot.create :user, name: 'all'

subs = 4.times.map { FactoryBot.create :sub }
all = FactoryBot.create :sub, name: 'all'

posts = 16.times { FactoryBot.create :post, user_id: users.sample.id, sub_id: subs.sample.id }
redditpost = FactoryBot.create :post, user_id: reddit_user.id, sub_id: all.id, title: 'reddit title', url: 'https://reddit.com', body: 'reddit body'
