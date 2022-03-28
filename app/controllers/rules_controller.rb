class RulesController < ApplicationController
  before_action :set_rule, only: %i[ show edit update destroy ]

  # GET /rules or /rules.json
  def index
    @rules = Rule.all.sort_by(&:order)
  end

  # GET /rules/1 or /rules/1.json
  def show
  end

  # GET /rules/new
  def new
    @rule = Rule.new
  end

  # GET /rules/1/edit
  def edit
  end

  # POST /rules or /rules.json
  def create
    @rule = Rule.new(rule_params)

    respond_to do |format|
      if @rule.save
        format.html do 
          url = params[:save_and_new?] ? new_rule_path : rules_path
          redirect_to url, notice: "Rule #{@rule.order} was successfully created." 
        end
        format.json { render :show, status: :created, location: @rule }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rules/1 or /rules/1.json
  def update
    respond_to do |format|
      if @rule.update(rule_params)
        format.html { redirect_to rule_url(@rule), notice: "Rule was successfully updated." }
        format.json { render :show, status: :ok, location: @rule }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1 or /rules/1.json
  def destroy
    @rule.destroy

    respond_to do |format|
      format.html { redirect_to rules_url, notice: "Rule was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule
      @rule = Rule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rule_params
      params.require(:rule).permit(:order, :text)
    end

end
