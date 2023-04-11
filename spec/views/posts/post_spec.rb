require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  before(:example) do
    @img = 'https://cdn.pixabay.com/photo/2023/03/07/18/07/chocolate-7836231_960_720.png'
    @user = User.create(name: 'John Doe', photo: @img, bio: 'live to bio', posts_counter: 12)
    @post = Post.create(author: @user, title: 'title', text: 'content')
    @comment = Comment.create(text: 'comment', post: @post, author: @user)
    @like = Like.create(post: @post, author: @user)
  end

  describe 'GET /posts' do
    before(:example) do
      visit user_posts_path(@user)
    end
    it 'I can see the profile picture for each user.' do
      expect(page).to have_css('img')
    end

    it 'shows the username' do
      expect(page).to have_content('John Doe')
    end
    it 'shows the number of posts' do
      expect(page).to have_content('Number of posts: 1')
    end
    it 'shows the post title' do
      expect(page).to have_content('title')
    end
    it 'shows the post content' do
      expect(page).to have_content('content')
    end
    it 'shows the first of comments' do
      expect(page).to have_content('comment')
    end
    it 'shows the number of comments' do
      expect(page).to have_content('comments: 1')
    end
    it 'shows the number of likes' do
      expect(page).to have_content('Likes: 1')
    end
    it 'when I click on the post id I can see the post' do
      find("a[href='/users/#{@user.id}/posts/#{@post.id}']").click
      sleep 1
      expect(current_path).to eq user_post_path(@user, @post)
    end
  end

  describe 'GET /posts/:id' do
    before(:example) do
      visit user_post_path(@user, @post)
    end
    it 'shows the post title' do
      expect(page).to have_content('title')
    end
    it "shows post author's name" do
      expect(page).to have_content('John Doe')
    end
    it 'shows the comments counter for the post' do
      expect(page).to have_content('comments: 1')
    end
    it 'shows the like counter for the post' do
      expect(page).to have_content('Likes: 1')
    end
    it 'shows the post content' do
      expect(page).to have_content('content')
    end
    it "shows the comment's author" do
      expect(page).to have_content(@comment.author.name)
    end
    it "shows the comment's content" do
      expect(page).to have_content(@comment.text)
    end
  end
end
