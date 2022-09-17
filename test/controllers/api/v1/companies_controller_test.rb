require "test_helper"

class Api::V1::CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company = companies(:one)
  end

  test 'should show all companies' do
    get api_v1_companies_url(), as: :json
    assert_response :success
  end

  test 'should show company' do
    get api_v1_company_url(@company), as: :json
    assert_response :success

    json_response = JSON.parse(self.response.body, symbolize_names: true)
    assert_equal @company.company_name, json_response.dig(:data, :attributes, :company_name)
  end

  test 'should create company' do
    assert_difference('Company.count') do
      post api_v1_companies_url,
        params: { company: { company_name: @company.company_name } },
        headers: { Authorization: JsonWebToken.encode(user_id: @company.user_id) }, as: :json
    end
    assert_response :created
  end

  test 'should forbid creating company' do
    assert_no_difference 'Company.count' do
      post api_v1_companies_url,
        params: { company: { company_name: @company.company_name } }, as: :json
    end
    assert_response :forbidden
  end

  test 'should update company' do
    patch api_v1_company_url(@company),
      params: { company: { company_name: @company.company_name } },
      headers: { Authorization: JsonWebToken.encode(user_id: @company.user_id) }, as: :json
    assert_response :success
    end

  test 'should forbid update company' do
    patch api_v1_company_url(@company),
      params: { company: { company_name: @company.company_name } },
      headers: { Authorization: JsonWebToken.encode(user_id: users(:two).id) }, as: :json
    assert_response :forbidden
  end

  test "should destroy company" do
    assert_difference('Company.count', -1) do
      delete api_v1_company_url(@company), 
        headers: {Authorization: JsonWebToken.encode(user_id: @company.user_id) }, as: :json
    end
    assert_response :no_content
  end

  test "should forbid destroy company" do
    assert_no_difference('Company.count') do
      delete api_v1_company_url(@company), 
        headers: {Authorization: JsonWebToken.encode(user_id: users(:two).id) }, as: :json
    end
    assert_response :forbidden
  end
end
