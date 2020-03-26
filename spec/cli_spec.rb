require_relative "../lib/cli.rb"


describe "CLI" do 
    let (:cli) {Cli.new}

    it "can be assigned a user" do 
        cli.user = User.find_by(username:"Tyler")
        expect(cli.user.username).to eq ("Tyler")
    end

    it "can use its user to call methods" do 
        cli.user = User.find_by(username:"Bob")
        expect(cli.user.reservations.length).to eq(1)
    end 

    it "can manage payments" do 
        cli.user = User.find_by(username:"Bob")
        expect(cli.unpaid_reservations.length).to eq(1)
        cli.user = User.find_by(username:"Tyler")
        expect(cli.unpaid_reservations.length).to eq(0)
    end

end