require 'spec_helper'

module PayuPayments

  describe CreditCard do
     it "should be able to validate a credit card" do
        cc = CreditCard.new
        expect(cc.valid?).to eq(false)
     end

     it "should tell me where the errors are" do
        cc = CreditCard.new
        cc.valid?
        expect(cc.errors.count).to be > 0
        expect(cc.errors.first[:field]).to eql(:customerId)
        expect(cc.errors.first[:message]).to eql("customerId can't be blank")
     end

     it "should not allow to save a credit card with erros" do
        expect(CreditCard.new.save).to be(false)
     end
  end
end
