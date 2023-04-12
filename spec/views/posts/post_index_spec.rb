require 'rails_helper'

RSpec.describe 'Posts index', type: :feature do
  before(:example) do
    @img = 'https://cdn.pixabay.com/photo/2023/03/07/18/07/chocolate-7836231_960_720.png'
    @user = User.create(name: 'John Doe', photo: @img, bio: 'live to bio', posts_counter: 12)
    @post = Post.create(author: @user, title: 'title', text: 'content')
    @comment = Comment.create(text: 'comment', post: @post, author: @user)
    @like = Like.create(post: @post, author: @user)
    visit user_posts_path(@user)
  end



  it 'I can see the profile picture for each user.' do
    expect(page).to have_css('img')
  end

  it 'shows the username' do
    expect(page).to have_content(@user.name)
  end

  it 'shows the number of posts' do
    expect(page).to have_content(@user.posts_counter)
  end

  it 'shows the post title' do
    expect(page).to have_content(@post.title)
  end

  it 'shows the post content' do
    expect(page).to have_content(@post.text)
  end

  it 'shows the first of comments' do
    expect(page).to have_content(@comment.text)
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
