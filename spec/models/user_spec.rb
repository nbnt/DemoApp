# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before {@user = User.new(name: "Someone", email: "Some@one.com", password: "foobar", password_confirmation: "foobar")}
  subject { @user }

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:authenticate)}
  it {should respond_to(:remember_token)}

  it {should be_valid}

  describe "when name is not present" do
    before {@user.name = ""}
    it {should_not be_valid}
  end

  describe "when email is not present" do
    before {@user.email = ""}
    it {should_not be_valid}
  end

  describe "when name is too long" do
    before {@user.name = "a"*51}
    it {should_not be_valid}
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[userr user@user user.com user!user user@user,com]
      addresses.each do |inv|
        @user.email = inv
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@user.com user.user@user.net user_666@user.user]
      addresses.each do |add|
        @user.email = add
        @user.should be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email.upcase
      user_with_same_email.save
    end

    it {should_not be_valid}
  end

  describe "when password is not present" do
    before {@user.password = @user.password_confirmation = " "}
    it {should_not be_valid}
  end

  describe "when password doesn't match confirmation" do
    before {@user.password_confirmation = "barfoo"}
    it {should_not be_valid}
  end

  describe "when password confirmation is nil" do
    before {@user.password_confirmation = nil}
    it {should_not be_valid}
  end

  describe "return value of authentication method" do
    before {@user.save}
    let(:found_user) {User.find_by_email(@user.email)}

    describe "with valid password" do
      it {should == found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
      let(:bad_user) {found_user.authenticate("barfoo")}
      it {should_not == bad_user}
      specify {bad_user.should be_false}
    end
  end

  describe "password is too short" do
    before {@user.password = @user.password_confirmation = "a"*5}
    it {should be_invalid}
  end

  describe "remember token" do
    before {@user.save}
    its(:remember_token) {should_not be_blank}
  end
end
