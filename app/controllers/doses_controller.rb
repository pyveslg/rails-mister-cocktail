class DosesController < ApplicationController

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @doses = []
    3.times do
      @doses << Dose.new
    end
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    params[:dose]["doses"].each do |dose|
      if dose[:ingredient_id] != "" || dose[:description] != ""
        @dose = Dose.new(dose_params(dose))
        @dose.cocktail = @cocktail
        @dose.save
      end
    end
    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to root_path
  end

  private

  def dose_params(my_params)
    my_params.permit(:description, :ingredient_id)
  end

  def set_cocktail
    @dose = Dose.find(params[:id])
  end

end
