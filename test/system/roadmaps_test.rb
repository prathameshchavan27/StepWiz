require "application_system_test_case"

class RoadmapsTest < ApplicationSystemTestCase
  setup do
    @roadmap = roadmaps(:one)
  end

  test "visiting the index" do
    visit roadmaps_url
    assert_selector "h1", text: "Roadmaps"
  end

  test "should create roadmap" do
    visit roadmaps_url
    click_on "New roadmap"

    fill_in "Description", with: @roadmap.description
    check "Public" if @roadmap.public
    fill_in "Title", with: @roadmap.title
    fill_in "User", with: @roadmap.user_id
    click_on "Create Roadmap"

    assert_text "Roadmap was successfully created"
    click_on "Back"
  end

  test "should update Roadmap" do
    visit roadmap_url(@roadmap)
    click_on "Edit this roadmap", match: :first

    fill_in "Description", with: @roadmap.description
    check "Public" if @roadmap.public
    fill_in "Title", with: @roadmap.title
    fill_in "User", with: @roadmap.user_id
    click_on "Update Roadmap"

    assert_text "Roadmap was successfully updated"
    click_on "Back"
  end

  test "should destroy Roadmap" do
    visit roadmap_url(@roadmap)
    click_on "Destroy this roadmap", match: :first

    assert_text "Roadmap was successfully destroyed"
  end
end
