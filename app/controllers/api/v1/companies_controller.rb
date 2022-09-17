class Api::V1::CompaniesController < ApplicationController
  before_action :set_company, only: %i[show update destroy]
  before_action :check_login, only: %i[create]
  before_action :check_owner, only: %i[update destroy]

  def index
    @companies = Company.all
    render json: CompanySerializer.new(@companies).serializable_hash.to_json
  end

  def show
    options = { include: [:user] }
    render json: CompanySerializer.new(@company, options).serializable_hash.to_json
  end

  def create
    company = current_user.companies.build(company_params)
    if company.save
      render json: CompanySerializer.new(company).serializable_hash.to_json, status: :created
    else
      render json: {errors: company.errors}, status: :unprocessable_entity
    end
  end

  def update
    if @company.update(company_params)
      render json: CompanySerializer.new(@company).serializable_hash.to_json
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @company.destroy
    head 204
  end

  private
  def company_params
    params.require(:company).permit(:company_name)
  end

  def set_company
    @company = Company.find(params[:id])
  end

  def check_owner
    head :forbidden unless @company.user_id == current_user&.id
  end
end
