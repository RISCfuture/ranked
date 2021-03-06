require 'rails_helper'

RSpec.describe StacksController, type: :controller do
  describe '#show' do
    render_views

    let(:stack) { FactoryBot.create :stack }

    it "should render the JSON for a stack" do
      get :show, params: {id: stack.to_param, format: 'json'}
      expect(response.status).to be(200)
      json = JSON.parse(response.body)
      expect(json['name']).to eql(stack.name)
      stack.cards.order(id: :asc).each_with_index do |card, index|
        expect(json['cards'][index]['name']).to eql(card.name)
      end
    end

    it "should include rankings if matches are given" do
      matches         = Array.new(stack.pairs_order.size) { %i[first second both].sample }
      encoded_matches = matches.map { |m| described_class.const_get(:MATCH_TYPES).index(m) }.
          join('').to_i(4).to_s(36)
      get :show, params: {id: stack.to_param, m: encoded_matches, format: 'json'}
      expect(response.status).to be(200)
      json = JSON.parse(response.body)
      expect(json['rankings']).to be_kind_of(Array)
      results = stack.rank(matches)
      expect(json['rankings']).to eql(results.map { |r| {'name' => r.first.name, 'ranking' => r.last} })
    end
  end

  describe '#create' do
    render_views

    it "should create a new stack with cards" do
      post :create, params: {stack: {name: "My Stack", card_names: "one\ntwo\nthree"}, format: 'json'}
      expect(response.status).to be(201)
      expect(Stack.count).to be(1)
      stack = Stack.first
      expect(stack.name).to eql("My Stack")
      expect(stack.cards.count).to be(3)
      expect(stack.cards.pluck(:name)).to match_array(%w[one two three])
    end

    it "should handle validation errors" do
      post :create, params: {stack: {name: " ", card_names: "one\ntwo\nthree"}, format: 'json'}
      expect(response.status).to be(422)
      expect(response.body).to eql('{"errors":{"name":[{"error":"blank"}]}}')
    end

    it "should handle validation errors on a card" do
      post :create, params: {stack: {name: "My Stack", card_names: ['one', 'two'*100, 'three'].join("\n")}, format: 'json'}
      expect(response.status).to be(422)
      json = JSON.parse(response.body)
      expect(json['errors']['cards'].first['error']).to eql('invalid')
    end
  end
end
