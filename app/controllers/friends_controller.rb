class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /friends or /friends.json
  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @friends = current_user.friends
    end
  end

  # GET /friends/1 or /friends/1.json
  def show
    if @friend.user != current_user
      redirect_to root_path
    end
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
    if @friend.user != current_user
      redirect_to root_path
    end
  end

  # POST /friends or /friends.json
  def create
    @friend = Friend.new(friend_params)
    @friend.user = current_user
    respond_to do |format|
      if @friend.save
        format.html { redirect_to @friend, notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    if @friend.user != current_user
      redirect_to root_path
    else
      respond_to do |format|
        if @friend.update(friend_params)
          format.html { redirect_to @friend, notice: "Friend was successfully updated." }
          format.json { render :show, status: :ok, location: @friend }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @friend.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    if @friend.user != current_user
      redirect_to root_path
    end
    @friend.destroy
    respond_to do |format|
      format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :phone, :twitter)
    end
end
