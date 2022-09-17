require "test_helper"

class Api::V1::ChemicalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chemical = chemicals(:one)
    @chemical_params = { chemical: { 
      company_ids: [companies(:one).id, companies(:two).id],
      total: 50
     } }
  end

  test "should show chemicals" do
    get api_v1_chemicals_url(), as: :json
    assert_response :success
  end

  test "should show chemical" do
    get api_v1_chemical_url(@chemical), as: :json
    assert_response :success
    
    json_response = JSON.parse(self.response.body, symbolize_names: true)
    assert_equal @chemical.chemical_name, json_response.dig(:data, :attributes, :chemical_name)
    assert_equal @chemical.synonym, json_response.dig(:data, :attributes, :synonym)
    assert_equal @chemical.cas, json_response.dig(:data, :attributes, :cas)
    assert_equal @chemical.user.id.to_s, json_response.dig(:data, :relationships, :user, :data, :id)
    assert_equal @chemical.user.email, json_response.dig(:included, 0, :attributes, :email)
    # assert_equal @chemical.company.company_name, json_response.dig(:included, 0, :attributes, :company_name)
    
    # json_response = JSON.parse(response.body)
    # include_company_attr = json_response['included'][0]['attributes']
    # assert_equal @chemical.companies.first.company_name, include_company_attr['company_name']
  end

  test 'should create chemical' do
    assert_difference('Chemical.count') do
      post api_v1_chemicals_url,
        params: { chemical: { chemical_name: @chemical.chemical_name, 
                              synonym: @chemical.synonym, 
                              cas: @chemical.cas } },
        headers: { Authorization: JsonWebToken.encode(user_id: @chemical.user_id) }, as: :json
    end
    assert_response :created
  end

  # test 'should create chemical with two companies' do
  #   assert_difference('Chemical.count', 1) do
  #     post api_v1_chemicals_url,
  #       params: @chemical_params,
  #       headers: { Authorization: JsonWebToken.encode(user_id: @chemical.user_id) },
  #       as: :json
  #       # puts assigns(:chemical).errors.inspect
  #   end
  #   assert_response :created
  # end
  
  test 'should forbid create chemical' do
    assert_no_difference('Chemical.count') do
      post api_v1_chemicals_url,
        params: { chemical: { chemical_name: @chemical.chemical_name, 
                              synonym: @chemical.synonym, 
                              cas: @chemical.cas } }, as: :json
    end
    assert_response :forbidden
  end

  test 'should update chemical' do
    patch api_v1_chemical_url(@chemical),
      params: { chemical: { chemical_name: @chemical.chemical_name } },
      headers: { Authorization: JsonWebToken.encode(user_id: @chemical.user_id) }, as: :json
    assert_response :success
  end
    
  test 'should forbid update chemical' do
    patch api_v1_chemical_url(@chemical),
      params: { chemical: { chemical_name: @chemical.chemical_name } },
      headers: { Authorization: JsonWebToken.encode(user_id: users(:two).id) }, as: :json
    assert_response :forbidden
  end

  test "should destroy chemical" do
    assert_difference('Chemical.count', -1) do
      delete api_v1_chemical_url(@chemical), 
        headers: { Authorization: JsonWebToken.encode(user_id: @chemical.user_id) }, as: :json
    end
    assert_response :no_content
  end
    
  test "should forbid destroy chemical" do
    assert_no_difference('Chemical.count') do
      delete api_v1_chemical_url(@chemical), 
        headers: { Authorization: JsonWebToken.encode(user_id: users(:two).id) }, as: :json
    end
    assert_response :forbidden
  end
end
