equire 'rails_helper'

RSpec.describe "User index", type: :feature do
  before :each do
    @user1 = User.create(name: 'Ali', photo: 'https://picsum.photos/300/200', bio: 'Software Engineer from Pakistan', posts_counter: 12)
    @post = Post.create(title: 'title', text: 'content', author: @user)
    @comment = Comment.create(text: 'comment', post: @post, author: @user)
    @like = Like.create(post: @post, author: @user)
  end
  describe 'GET /posts' do
    before(:example) do
      visit user_posts_path(@user)
    end
    it 'I can see the image' do
      expect(page.find('img')['src']).to have_content @user.photo
    end
    it 'I can see the username' do
      expect(page).to have_content('John Doe')
    end
    it 'I can see the number of posts' do
      expect(page).to have_content('Number of posts: 1')
    end
    it 'I can see the post title' do
      expect(page).to have_content('title')
    end
    it 'I can see the post content' do
      expect(page).to have_content('content')
    end
    it 'I can see the first of comments' do
      expect(page).to have_content('comment')
    end
    it 'I can see the number of comments' do
      expect(page).to have_content('Comments: 1')
    end
    it 'I can see the number of likes' do
      expect(page).to have_content('Likes: 1')
    end
    it 'when I click on the post title I can see the post' do
      find("a[href='/users/#{@user.id}/posts/#{@post.id}']").click
      sleep 1
      expect(current_path).to eq user_post_path(@user, @post)
    end
  end
  describe 'GET /posts/:id' do
    before(:example) do
      visit user_post_path(@user, @post)
    end
    it 'I can see the post title' do
      expect(page).to have_content('title')
    end
    it "I can see post author's name" do
      expect(page).to have_content('John Doe')
    end
    it 'I can see how many comments the post has' do
      expect(page).to have_content('Comments: 1')
    end
    it 'I can see how many likes the post has' do
      expect(page).to have_content('Likes: 1')
    end
    it 'I can see the post content' do
      expect(page).to have_content('content')
    end
    it "I can see the username of the comment's author" do
      expect(page).to have_content(@comment.author.name)
    end
    it "I can see the comment's content" do
      expect(page).to have_content(@comment.text)
    end
  end  
end