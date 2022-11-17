require './lib/caesar_cipher'

describe '#cipher' do 
    it "doesnt change special characters" do
        expect(cipher("!@#$%^d",4)).to eql("!@#$%^h")
    end

    it "correctly changes letter according to the shift amount" do
        expect(cipher("however",1)).to eql("ipxfwfs")
    end

    it "correctly wraps around" do
        expect(cipher("xyz!",4)).to eql("bcd!")
    end
end
