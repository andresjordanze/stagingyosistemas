require 'spec_helper'

  describe TemasController do
  before(:each) do
    controller.class.skip_before_filter :require_log_in #para evitar este filtro de application_controller

  end
  describe 'GET #new' do
    grupo = FactoryGirl.build(:grupo)
    it "muestra la vista new" do
      get :new
      expect(response).to render_template :new
    end
  end  
end