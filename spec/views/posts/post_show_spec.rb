require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  before(:example) do
    @img = 'https://cdn.pixabay.com/photo/2023/03/07/18/07/chocolate-7836231_960_720.png'
    @user = User.create(name: 'John Doe', photo: @img, bio: 'live to bio', posts_counter: 12)
    @post = Post.create(author: @user, title: 'title', text: 'content')
    @comment = Comment.create(text: 'comment', post: @post, author: @user)
    @like = Like.create(post: @post, author: @user)
    visit user_post_path(@user, @post)
  end

  it 'shows the post title' do
    expect(page).to have_content(@post.title)
  end

  it "shows post author's name" do
    expect(page).to have_content(@post.author.name)
  end

  it 'shows the comments counter for the post' do
    expect(page).to have_content('comments: 1')
  end

  it 'shows the like counter for the post' do
    expect(page).to have_content('Likes: 1')
  end

  it 'shows the post content' do
    expect(page).to have_content(@post.text)
  end

  it "shows the comment's author" do
    expect(page).to have_content(@comment.author.name)
  end

  it "shows the comment's content" do
    expect(page).to have_content(@comment.text)
  end
end
