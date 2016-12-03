require 'rails_helper'

describe App do
	before do
		stub_api_for(App) do |stub|
			stub.get("/apps") {
				|env| [
					 200,
					 {},
					 [
					    { id: 1, }
					 ].to_json]
			}
		end
	end

	subject { App.index }
	its(:name) { should == "bluehelmet-dev"  }
	its(:errors) { should be_empty }

end