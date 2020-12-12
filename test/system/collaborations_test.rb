require "application_system_test_case"

class CollaborationsTest < ApplicationSystemTestCase
  setup do
    @collaboration = collaborations(:one)
  end

  test "visiting the index" do
    visit collaborations_url
    assert_selector "h1", text: "Collaborations"
  end

  test "creating a Collaboration" do
    visit collaborations_url
    click_on "New Collaboration"

    fill_in "Note", with: @collaboration.note_id
    fill_in "User", with: @collaboration.user_id
    click_on "Create Collaboration"

    assert_text "Collaboration was successfully created"
    click_on "Back"
  end

  test "updating a Collaboration" do
    visit collaborations_url
    click_on "Edit", match: :first

    fill_in "Note", with: @collaboration.note_id
    fill_in "User", with: @collaboration.user_id
    click_on "Update Collaboration"

    assert_text "Collaboration was successfully updated"
    click_on "Back"
  end

  test "destroying a Collaboration" do
    visit collaborations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Collaboration was successfully destroyed"
  end
end
