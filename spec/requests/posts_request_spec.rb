require 'rails_helper'

RSpec.describe "Posts", type: :request do
	# indexアクションのテスト
	context 'GET #index' do
		before { get root_path }

		# リクエストに対するレスポンステスト
		it 'responds successfully' do
				expect(response).to have_http_status 200
		end
	end

end
