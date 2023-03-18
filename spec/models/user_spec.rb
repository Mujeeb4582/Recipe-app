require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food, user:) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }
  let(:recipe_food) { FactoryBot.create(:recipe_food, food:, recipe:) }

  it 'has name' do
    expect(user.name).to be_present
  end
end
