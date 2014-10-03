require 'spec_helper'

feature 'Gestion de Sessions' do
	grupo = FactoryGirl.create(:grupo)
	grupo = FactoryGirl.build(:grupo)
  scenario 'Log in de un usuario' do    
    usuario = FactoryGirl.build(:usuario)      
    visit root_path
    fill_in 'correo', with: 'email@email.com'
    fill_in 'contrasenia', with: 'password'
    click_button 'Ingresar'   
  end
end
