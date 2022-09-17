class Api::V1::ChemicalsController < ApplicationController
  before_action :set_chemical, only: %i[show update destroy] 
  before_action :check_login, only: %i[create]
  before_action :check_owner, only: %i[update destroy]

  def index
    @chemicals = Chemical.all
    render json: ChemicalSerializer.new(@chemicals).serializable_hash.to_json
  end

  def show
    options = { include: [:user, :companies] }
    render json: ChemicalSerializer.new(@chemical, options).serializable_hash.to_json
  end

  def create
    chemical = current_user.chemicals.build(chemical_params)
    if chemical.save
      render json: ChemicalSerializer.new(chemical).serializable_hash.to_json, status: :created
    else
      render json: { errors: chemical.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @chemical.update(chemical_params)
      render json: ChemicalSerializer.new(@chemical).serializable_hash.to_json
    else
      render json: @chemical.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @chemical.destroy
    head 204
  end

  private
  def chemical_params
    params.require(:chemical).permit(:chemical_name, :synonym, :cas, company_ids: [])
  end

  def check_owner
    head :forbidden unless @chemical.user_id == current_user&.id
  end
  
  def set_chemical
    @chemical = Chemical.find(params[:id])
  end
end
