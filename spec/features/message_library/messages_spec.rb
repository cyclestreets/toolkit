# frozen_string_literal: true

require "spec_helper"

# Creating library items from messages
describe "Library Messages" do
  context "signed in" do
    include_context "signed in as a site user"

    context "plain messages" do
      let(:message) { create(:message) }

      xit "should create a library note from a message" do
        visit thread_path(message.thread)

        # Positive test for negative variants, below
        expect(page).to have_content("Create")

        within ".message", match: :first do
          click_on I18n.t(".messages.message.create_note")
        end

        click_on "Create Note"
        expect(page.current_path).to eq(library_note_path(Library::Note.last))
        expect(page).to have_content(message.body)
      end
    end

    context "document messages" do
      let(:message) { create(:document_message) }

      xit "should create a library document from a document message" do
        visit thread_path(message.thread)

        # Positive test for negative variants, below
        expect(page).to have_content("Create")

        within ".message", match: :first do
          click_on I18n.t(".messages.message.create_document")
        end

        click_on "Add to Library"
        expect(page.current_path).to eq(library_document_path(Library::Document.last))
        expect(page).to have_content(message.title)
        expect(page).to have_link("Download document")
      end

      xit "should fill show the right form" do
        visit thread_path(message.thread)
        within ".message", match: :first do
          click_on I18n.t(".messages.message.create_document")
        end

        expect(page).to have_field("Title")
        expect(page).not_to have_field("Document")
      end

      xit "should end up with the correct document" do
        visit thread_path(message.thread)
        within ".message", match: :first do
          click_on I18n.t(".messages.message.create_document")
        end

        click_on "Add to Library"
        expect(message.file.size).to eq(Library::Document.last.file.size)
      end
    end

    context "photo messages" do
      let(:message) { create(:photo_message) }

      it "should not let you create a library item" do
        visit thread_path(message.thread)

        expect(page).not_to have_content "Create"
      end
    end

    context "deadline messages" do
      let(:message) { create(:deadline_message) }

      it "should not let you create a library item" do
        visit thread_path(message.thread)

        expect(page).not_to have_content "Create"
      end
    end

    context "url messages" do
      let(:message) { create(:link_message) }

      it "should not let you create a library item" do
        visit thread_path(message.thread)

        expect(page).not_to have_content "Create"
      end
    end

    context "library item messages" do
      let(:message) { create(:library_item_message_with_document) }

      it "should not let the world implode" do
        message.message.save! # required for overly-complex reasons involving components-in-components
        visit thread_path(message.thread)

        expect(page).not_to have_content "Create"
      end
    end
  end
end
