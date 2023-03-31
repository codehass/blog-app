require 'rails_helper'

RSpec.describe Post, type: :model do
  # tests go here
  subject { Post.new(title: 'Ruby on Rails', text: 'I love rails', comments_counter: 6, likes_counter: 10) }

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should not be valid' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be integer >= 0' do
    subject.likes_counter = -3
    expect(subject).to_not be_valid
  end

  it 'comments_count should be integer >= 0' do
    subject.comments_counter = -6
    expect(subject).to_not be_valid
  end

  it 'Displayed 6 comments limit' do
    expect(subject.comments_counter).to eql(6)
  end

  it 'Displayed 10 likes limit' do
    expect(subject.likes_counter).to eql(10)
  end
end
