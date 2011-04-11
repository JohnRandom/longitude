describe Route do
  describe "creation" do
    it 'should validate :name and :user_id' do
      Route.create.should have(1).error_on(:name)
      Route.create.should have(1).error_on(:user_id)
    end

    it 'should create validated records' do
      Route.create(:name => 'test', :user_id => 1).should_not be nil
    end

  end
end
