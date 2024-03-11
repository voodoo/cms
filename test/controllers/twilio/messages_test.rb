require "test_helper"


describe Twilios::MessagesController do

  describe "POST :create without media" do

    before do
      request.accept = "application/xml"

      post :create, payload 
    end
      

    let :payload do
      {
        To: '111-111-1111',
        From: '222-222-2222',
        Body: 'Hello'
      }
    end

    it "has the right content" do
      assert_equal(Comment.last.comment, 'Hello')
    end

    it "has not attached media" do
      assert_equal(Comment.last.medias.count, 0)
    end

    it "renders create" do
      must_render_template "create"
    end

  end

  describe "POST :create with media" do

    before do
      request.accept = "application/xml"
      post :create, payload 
    end

    let :payload do
      {
        To: '111-111-1111',
        From: '222-222-2222',
        Body: "#122\n\nHello",
        NumMedia: 1,
        MediaContentType0: 'text',
        MediaUrl0: 'http://something.com/'

      }
    end

    let :comment do
      Comment.last
    end

    it "has the right content" do
      assert_includes(comment.comment, '#122')
    end

    it "has attached media" do
      assert_equal(comment.medias.count, 1)
    end

    it "media has right data" do
      assert_equal(comment.medias.first.url, 'http://something.com/')
    end    

    it "renders create" do
      must_render_template "create"
    end

    it "is attached to invoice" do
      assert_equal(comment.commentable,Invoice.find(122))
    end    

  end
end

