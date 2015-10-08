require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should have_many(:users) }
  it { should have_many(:memberships) }

  it { should have_valid(:name).when("name", "croc tears") }
  it { should_not have_valid(:name).when(nil, '') }
end
