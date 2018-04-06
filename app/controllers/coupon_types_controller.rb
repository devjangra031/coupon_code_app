class CouponTypesController < ApplicationController
  before_action :set_coupon_type, only: [:show, :edit, :update, :destroy]

  # GET /coupon_types
  # GET /coupon_types.json
  def index
    @coupon_types = CouponType.all
  end

  # GET /coupon_types/1
  # GET /coupon_types/1.json
  def show
  end

  # GET /coupon_types/new
  def new
    @coupon_type = CouponType.new
  end

  # GET /coupon_types/1/edit
  def edit
  end

  # POST /coupon_types
  # POST /coupon_types.json
  def create
    @coupon_type = CouponType.new(coupon_type_params)

    respond_to do |format|
      if @coupon_type.save
        format.html { redirect_to @coupon_type, notice: 'Coupon type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @coupon_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @coupon_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupon_types/1
  # PATCH/PUT /coupon_types/1.json
  def update
    respond_to do |format|
      if @coupon_type.update(coupon_type_params)
        format.html { redirect_to @coupon_type, notice: 'Coupon type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coupon_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupon_types/1
  # DELETE /coupon_types/1.json
  def destroy
    @coupon_type.destroy
    respond_to do |format|
      format.html { redirect_to coupon_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon_type
      @coupon_type = CouponType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_type_params
      params.require(:coupon_type).permit(:name)
    end
end
