 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/items", type: :request do

  # Item. As you add validations to Item, be sure to
  # adjust the attributes here as well.
  let!(:valid_test_folder) { Folder.create(name: 'Test') }
  let(:valid_attributes) do
    { attachment: Rack::Test::UploadedFile.new(File.open("#{Rails.root}/spec/files/test.txt")), folder_id: valid_test_folder.id }
  end
  let(:valid_params) do
    { attachment: Rack::Test::UploadedFile.new(File.open("#{Rails.root}/spec/files/test.txt")), folder_name: valid_test_folder.name }
  end

  let(:invalid_attributes) do
    { attachment: File.open("#{Rails.root}/spec/files/test.txt") }
  end

  describe "GET /index" do
    it "renders a successful response" do
      Item.create! valid_attributes
      get items_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      item = Item.create! valid_attributes
      get item_url(item)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_item_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      item = Item.create! valid_attributes
      get edit_item_url(item)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Item" do
        expect do
          post items_url, params: { item: valid_params }
        end.to change(Item, :count).by(1)
      end

      it "redirects to the created item" do
        post items_url, params: { item: valid_params }

        expect(response).to redirect_to(item_url(Item.take))
      end

      context 'with JSON format' do
        it 'creates a new Item' do
          expect do
            post items_url, params: { item: valid_params, format: :json }
          end.to change(Item, :count).by(1)
        end

        it 'should have response status :created' do
          post items_url, params: { item: valid_params, format: :json }

          expect(response).to be_created
        end
      end
    end

    context "with invalid parameters" do
      it "does not create a new Item" do
        expect {
          post items_url, params: { item: invalid_attributes }
        }.to change(Item, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post items_url, params: { item: invalid_attributes }
        expect(response).to be_unprocessable
      end

      context 'with JSON format' do
        it "does not create a new Item" do
          expect {
            post items_url, params: { item: invalid_attributes, format: :json}
          }.to change(Item, :count).by(0)
        end

        it 'should be unprocessable' do
          post items_url, params: { item: invalid_attributes, format: :json}

          expect(response).to be_unprocessable
        end
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { attachment: Rack::Test::UploadedFile.new(File.open("#{Rails.root}/spec/files/test.txt")), folder_name: valid_test_folder.name }
      end

      it "updates the requested item" do
        item = Item.create! valid_attributes
        expect do
          patch item_url(item), params: { item: new_attributes }
          item.reload
        end.to change(item, :updated_at)
      end

      it "redirects to the item" do
        item = Item.create! valid_attributes
        patch item_url(item), params: { item: new_attributes }
        item.reload
        expect(response).to redirect_to(item_url(item))
      end

      context 'with JSON format' do
        it "updates the requested item" do
          item = Item.create! valid_attributes

          expect do
            patch item_url(item), params: { item: new_attributes, format: :json }

            item.reload
          end.to change(item, :updated_at)
        end

        it 'should be successful' do
          item = Item.create! valid_attributes

          patch item_url(item), params: { item: new_attributes, format: :json }
          item.reload

          expect(response).to be_successful
        end
      end
    end

    context 'with invalid parameters' do
      it 'should be unprocessable' do
        item = Item.create! valid_attributes
        patch item_url(item), params: { item: invalid_attributes }
        expect(response).to be_unprocessable
      end

      context 'with JSON format' do
        it 'should be unprocessable' do
          item = Item.create! valid_attributes
          patch item_url(item), params: { item: invalid_attributes, format: :json}
          expect(response).to be_unprocessable
        end
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested item" do
      item = Item.create! valid_attributes
      expect {
        delete item_url(item)
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the items list" do
      item = Item.create! valid_attributes
      delete item_url(item)
      expect(response).to redirect_to(items_url)
    end

    context 'with JSON format' do
      it 'destroys the requested item' do
        item = Item.create! valid_attributes
        expect {
          delete item_url(item), params: { format: :json }
        }.to change(Item, :count).by(-1)
      end
    end
  end
end
