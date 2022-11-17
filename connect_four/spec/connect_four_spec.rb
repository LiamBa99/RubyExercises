require './lib/connect_four'


describe ConnectFour do
    describe '#get input' do
        it "correctly places symbol according to input" do
            game = ConnectFour.new()
            game.get_input(" X ", 1)
            expect(game.board[5][0]).to eql(" X ")
        end
    end

    describe '#check win' do
        it "correctly checks for win in a line" do
            game = ConnectFour.new()
            game.get_input(" O ", 1)
            game.get_input(" O ", 2)
            game.get_input(" O ", 3)
            game.get_input(" O ", 4)
            #game.printboard
            expect(game.check_line(5, " O ")).to eql(true)
        end
    end

    describe '#check win' do
        it "correctly checks for no win in a line" do
            game = ConnectFour.new()
            game.get_input(" O ", 1)
            game.get_input(" X ", 2)
            game.get_input(" O ", 3)
            game.get_input(" O ", 4)
            #game.printboard
            expect(game.check_line(5," O ")).to eql(false)
        end
    end

    describe '#check win' do
        it "correctly checks for win in a diagonal line" do
            game = ConnectFour.new()
            game.get_input(" O ", 1)
            game.get_input(" X ", 2)
            game.get_input(" O ", 3)
            game.get_input(" O ", 4)
            game.get_input(" O ", 2)
            game.get_input(" O ", 3)
            game.get_input(" O ", 3)
            game.get_input(" O ", 4)
            game.get_input(" O ", 4)
            game.get_input(" O ", 4)
            game.printboard
            expect(game.check_diagonal([2,3], " O ")).to eql(true)
        end
    end

    describe '#check win' do
        it "correctly checks for win in a diagonal line" do
            game = ConnectFour.new()
            game.get_input(" O ", 1)
            game.get_input(" X ", 2)
            game.get_input(" O ", 3)
            game.get_input(" O ", 4)
            game.get_input(" O ", 2)
            game.get_input(" O ", 3)
            game.get_input(" O ", 3)
            game.get_input(" O ", 4)
            game.get_input(" O ", 4)
            game.get_input(" X ", 4)
            game.printboard
            expect(game.check_diagonal([2,3], " O ")).to eql(false)
        end
    end

    describe '#check win' do
        it "correctly checks for win in a vertical line" do
            game = ConnectFour.new()
            game.get_input(" O ", 1)
            game.get_input(" X ", 2)
            game.get_input(" O ", 3)
            game.get_input(" O ", 4)
            game.get_input(" O ", 2)
            game.get_input(" O ", 3)
            game.get_input(" O ", 3)
            game.get_input(" O ", 4)
            game.get_input(" O ", 4)
            game.get_input(" O ", 4)
            game.printboard
            expect(game.check_vertical([2,3], " O ")).to eql(true)
        end
    end

    describe '#check win' do
        it "correctly checks for lose in a vertical line" do
            game = ConnectFour.new()
            game.get_input(" O ", 1)
            game.get_input(" X ", 2)
            game.get_input(" O ", 3)
            game.get_input(" O ", 4)
            game.get_input(" O ", 2)
            game.get_input(" O ", 3)
            game.get_input(" O ", 3)
            game.get_input(" O ", 4)
            game.get_input(" O ", 4)
            game.get_input(" X ", 4)
            game.printboard
            expect(game.check_vertical([2,3], " O ")).to eql(false)
        end
    end
end
