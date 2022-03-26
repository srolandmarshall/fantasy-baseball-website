require "application_system_test_case"

class PlayersTest < ApplicationSystemTestCase
  setup do
    @player = players(:one)
  end

  test "visiting the index" do
    visit players_url
    assert_selector "h1", text: "Players"
  end

  test "should create player" do
    visit players_url
    click_on "New player"

    fill_in "Adp", with: @player.adp
    fill_in "Avg cost", with: @player.avg_cost
    fill_in "Name", with: @player.name
    fill_in "Position", with: @player.position
    fill_in "Rank", with: @player.rank
    fill_in "Team", with: @player.team
    click_on "Create Player"

    assert_text "Player was successfully created"
    click_on "Back"
  end

  test "should update Player" do
    visit player_url(@player)
    click_on "Edit this player", match: :first

    fill_in "Adp", with: @player.adp
    fill_in "Avg cost", with: @player.avg_cost
    fill_in "Name", with: @player.name
    fill_in "Position", with: @player.position
    fill_in "Rank", with: @player.rank
    fill_in "Team", with: @player.team
    click_on "Update Player"

    assert_text "Player was successfully updated"
    click_on "Back"
  end

  test "should destroy Player" do
    visit player_url(@player)
    click_on "Destroy this player", match: :first

    assert_text "Player was successfully destroyed"
  end
end
