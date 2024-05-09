# frozen_string_literal: true

require 'rspec'

RSpec.describe Arrysack::Query do
  subject { Arrysack::Query.new(params, schema).on(users) }
  let(:schema) {}

  include_context 'collections'

  context 'when query simple' do
    let(:params) { { first_name_cont: 'a', created_at_gt: '2024-07-06 12:00:00 +0500' } }
    it 'succeeds' do
      expect(subject.result.map { |u| u[:id] }).to eq([4, 11, 12])
    end
  end

  context 'when query simple in array' do
    let(:params) { { posts_comments_user_id_cont: 3 } }
    it 'succeeds' do
      expect(subject.result.map { |u| u[:id] }).to eq([4, 5, 7, 8, 11])
    end
  end

  context 'when query advanced' do
    let(:params) do
      { 'g' =>
         { '0' =>
            { 'm' => 'and',
              'c' =>
               { '0' => { 'a' => { '0' => { 'name' => 'first_name' } },
                          'p' => 'cont',
                          'v' => { '0' => { 'value' => 'a' } } },
                 '1' => { 'a' => { '0' => { 'name' => 'created_at' } },
                          'p' => 'gt',
                          'v' => { '0' => { 'value' => '2024-07-06 12:00:00 +0500' } } } } } } }
    end
    it 'succeeds' do
      expect(subject.result.map { |u| u[:id] }).to eq([4, 11, 12])
    end
  end

  context 'when query advanced in array' do
    let(:params) do
      { 'g' =>
          { '0' =>
              { 'm' => 'or',
                'c' =>
                  { '0' => { 'a' => { '0' => { 'name' => 'posts_comments_user_id' } },
                             'p' => 'cont',
                             'v' => { '0' => { 'value' => '3' } } } } } } }
    end
    it 'succeeds' do
      expect(subject.result.map { |u| u[:id] }).to eq([4, 5, 7, 8, 11])
    end
  end

  context 'when query advanced with nested group' do
    let(:params) do
      { 'g' =>
          { '0' =>
              { 'm' => 'or',
                'c' =>
                  { '0' => { 'a' => { '0' => { 'name' => 'first_name' } },
                             'p' => 'cont',
                             'v' => { '0' => { 'value' => 'a' } } },
                    '1' => { 'a' => { '0' => { 'name' => 'id' } },
                             'p' => 'lt',
                             'v' => { '0' => { 'value' => '8' } } },
                    '3' => { 'a' => { '0' => { 'name' => 'posts_title' } },
                             'p' => 'start',
                             'v' => { '0' => { 'value' => 'V' } } } },
                'g' => { '0' => { 'm' => 'or',
                                  'c' => { '0' => { 'a' => { '0' => { 'name' => 'email' } },
                                                    'p' => 'cont',
                                                    'v' => { '0' => { 'value' => 'v' } } } } } } } } }
    end
    it 'succeeds' do
      expect(subject.result.map { |u| u[:id] }).to eq([4, 5, 6, 7, 9, 11, 12, 13])
    end
  end
end
