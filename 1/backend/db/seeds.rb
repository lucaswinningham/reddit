reddituser = FactoryBot.create :user, name: 'reddituser', email: 'reddituser@emample.com'
users = 4.times.map { FactoryBot.create :user }

redditsub = FactoryBot.create :sub, name: 'redditsub'
subs = 4.times.map { FactoryBot.create :sub }

posts = 16.times { FactoryBot.create :post, user_id: users.sample.id, sub_id: subs.sample.id }
redditpost = FactoryBot.create :post, user_id: reddituser.id, sub_id: redditsub.id, title: 'reddit title', url: 'https://reddit.com', body: 'reddit body'

comments = 64.times { FactoryBot.create :comment, user_id: users.sample.id, commentable: (Post.all + Comment.all).sample }
redditcomment = FactoryBot.create :comment, user_id: reddituser.id, content: 'reddit comment', commentable: redditpost

votes = 1024.times do
  FactoryBot.create(
    :vote,
    user: users.sample,
    direction: Faker::Boolean.boolean(0.8),
    voteable: (Post.all + Comment.all).sample
  )
end

redditvote = FactoryBot.create(
  :vote,
  user: reddituser,
  direction: true,
  voteable: redditpost
)
