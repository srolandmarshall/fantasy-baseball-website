class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update destroy ]

  # GET /players or /players.json
  def index
    @players = Player.all.sort_by { |player| player.rank }
    @positions = Player.positions.sort_by { |pos| pos.downcase }
    respond_to do |format|
      format.html { render template: "players/index" }
      format.xlsx { render xlsx: 'players', filename: 'players.xlsx' }
    end
  end

  # GET /players/pitchers
  def pitchers
    @players = Player.pitchers
    @positions = Player::PITCHER_POSITIONS
    @other_positions = (Player.positions - Player::PITCHER_POSITIONS).sort_by { |pos| pos.downcase }
    render template: "players/_by_position", locals: { players: @players }
  end

  # GET /players/batters
  def batters
    @positions = Player.positions - Player::PITCHER_POSITIONS
    @other_positions = Player::PITCHER_POSITIONS
    @players = Player.batters
    render template: "players/_by_position", locals: { players: @players }
  end

  def by_position
    @positions = [params[:position]] || params[:positions]
    @other_positions = (Player.positions - @positions).sort_by { |pos| pos.downcase }
    @players = Player.by_position(@positions)
    render template: "players/_by_position", locals: { players: @players }
  end

  # GET /players/1 or /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players or /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to player_url(@player), notice: "Player was successfully created." }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1 or /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to player_url(@player), notice: "Player was successfully updated." }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1 or /players/1.json
  def destroy
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url, notice: "Player was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit(:rank, :name, :position, :team, :adp, :avg_cost, :is_keeper, :draft_round, :draft_pick_number)
    end

    def players_to_xlsx
      @players = Player.all
      @players.each do |player|
        player
      end
    end
end
