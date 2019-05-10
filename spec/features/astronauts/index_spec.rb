require "rails_helper"

RSpec.describe "As a visitor" do
  describe "when I visit '/astronauts'" do
    before :each do
      @neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
      @buzz = Astronaut.create!(name: "Buzz Aldren", age: 31, job: "Navigator")
      @gemini_7 = @buzz.missions.create!(title: "Gemini 7", time_in_space: 150)
      @capricorn_4 = @neil.missions.create!(title: "Capricorn 4", time_in_space: 100)
      @apollo_11 = @neil.missions.create!(title: "Apollo 11", time_in_space: 300)
      @apollo_12 = @buzz.missions.create!(title: "Apollo 12", time_in_space: 200)
    end

    it "shows a list of astronauts with info" do
      visit "/astronauts"

      within("#astronaut-#{@neil.id}-info") do
        expect(page).to have_content("Name: #{@neil.name}")
        expect(page).to have_content("Age: #{@neil.age}")
        expect(page).to have_content("Job: #{@neil.job}")
        expect(page).to have_content("Total Time in Space: 400 days")
      end

      within("#astronaut-#{@buzz.id}-info") do
        expect(page).to have_content("Name: #{@buzz.name}")
        expect(page).to have_content("Age: #{@buzz.age}")
        expect(page).to have_content("Job: #{@buzz.job}")
        expect(page).to have_content("Total Time in Space: 350 days")
      end
    end

    it "shows the average age of all astronauts" do
      visit "/astronauts"

      within("#statistics") do
        expect(page).to have_content("Average Age: 34")
      end
    end

    it "shows a list of space missions in alphabetical order" do
      visit "/astronauts"

      within("#astronaut-#{@neil.id}-info") do
        expect(page.all('li')[0]).to have_content("#{@apollo_11.title}")
        expect(page.all('li')[1]).to have_content("#{@capricorn_4.title}")
      end

      within("#astronaut-#{@buzz.id}-info") do
        expect(page.all('li')[0]).to have_content("#{@apollo_12.title}")
        expect(page.all('li')[1]).to have_content("#{@gemini_7.title}")
      end
    end
  end
end
