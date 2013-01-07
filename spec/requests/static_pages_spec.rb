require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have a correct title" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "RoR Sample | Home")
    end

    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => "Sample App")
    end
  end

  describe "Help page" do

    it "should have a correct title" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => "RoR Sample | Help")
    end

    it "should contain 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', :text => "Help")
    end
  end

  describe "About page" do

    it "should have a correct title" do
      visit '/static_pages/about'
      page.should have_selector('title', :text => "RoR Sample | About")
    end

    it "should contain 'About us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', :text => "About us")
    end
  end
end