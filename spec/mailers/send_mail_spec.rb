require "spec_helper"
describe SendMail do
  describe 'confirmation mail' do
    let(:user) { mock_model(Usuario, :nombre => 'Pedro', :correo => 'pedro@email.com', :id=>"1") }
    let(:mail) { SendMail.activate_acount(user) }
 
    #ensure that the subject is correct
    it 'validate the subject' do
      mail.subject.should == 'YoSistemas'
    end

    it 'validate to' do
      mail.to.should == [user.correo]
    end
	it 'validate from' do
      mail.from.should == ['YoSistemas@gmail.com']
    end

   it ' validate name' do
      mail.body.encoded.should match(user.nombre)
    end

  end
end



