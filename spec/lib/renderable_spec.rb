# -*- encoding: utf-8 -*-
require './spec/spec_helper'

describe RailsCsvRenderer::Renderable do
  before(:all) do
    Person.create(first_name: 'John', last_name: 'Smith')
    Person.create(first_name: 'Adam', last_name: 'Kowalczyk')
    Person.create(first_name: 'Dennis', last_name: 'Menace')
    Cat.create(name: 'Kitty')
  end

  let(:renderable_collection) { collection.extend RailsCsvRenderer::Renderable }

  context 'object is a ' do

    context 'nil' do
      let(:collection) { nil }

      it 'returns an empty string' do
        expect(renderable_collection.to_custom_csv).to eql("")
      end
    end

    context 'empty array' do
      let(:collection) { Array.new }

      it 'returns an empty string' do
        expect(renderable_collection.to_custom_csv).to eql("\n")
      end
    end

    context 'object is not an instance of AR class' do
      let(:collection) { [1, 2, 3] }

      it 'includes a csv of the collection' do
        expect(renderable_collection.to_custom_csv).to eql("1,2,3\n")
      end
    end

    context 'colection of Active Records' do
      context 'empty ActiveRelation' do
        let(:collection) { Person.where(first_name: 'qwerty') }

        it 'includes header' do
          expect(renderable_collection.to_custom_csv).to eql "Id,Full name\n"
        end
      end

      context 'with elements' do
        let(:collection) { Person.all }

        context 'with localized name of atributes' do
          before { I18n.locale = :ru }
          after { I18n.locale = :en }

          it 'includes localized column names in header' do
            expect(renderable_collection.to_custom_csv).to eql "ID,Полное имя\n1,John Smith\n2,Adam Kowalczyk\n3,Dennis Menace\n"
          end
        end

        context 'with csv options' do
          it 'includes columns and methods with configured separators' do
            options = { col_sep: "\t", row_sep: "\r\n" }
            expect(renderable_collection.to_custom_csv(options)).to eql "Id\tFull name\r\n1\tJohn Smith\r\n2\tAdam Kowalczyk\r\n3\tDennis Menace\r\n"
          end
        end

        context 'with undefined configuration methods' do
          let(:owner) { Person.last }
          let(:collection) { Cat.all }

          it 'includes csv with all model columns' do
            owner.cats << Cat.first
            expect(renderable_collection.to_custom_csv).to eql "Id,Name,Person\n1,Kitty,#{ owner.id }\n"
          end
        end
      end

      context 'object is array of ActiveRecords' do
        let(:collection) { [Person.first] }

        it 'includes a csv of the collection' do
          expect(renderable_collection.to_custom_csv).to eql "Id,Full name\n1,John Smith\n"
        end
      end
    end
  end
end
