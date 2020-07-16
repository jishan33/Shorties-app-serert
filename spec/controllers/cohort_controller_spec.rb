require "rails_helper"

RSpec.describe CohortsController, type: :controller do
  it do
    attributes = attributes_for(:cohort)
    should permit(:name)
        .for(:create, params: { cohort: attributes })
        .on(:cohort)
  end
end
