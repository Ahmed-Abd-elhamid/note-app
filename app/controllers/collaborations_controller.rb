class CollaborationsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:create]
  before_action :set_note_collaboration, only: [:show, :edit, :update, :destroy]
  before_action :set_note_vaidate, only: [:create]

  # GET /collaborations
  # GET /collaborations.json
  def index
    @collaborations = Collaboration.where(user_id: current_user.id)
    if params[:q]
      @collaborations = @collaborations.joins(:note).where('lower(title) LIKE :q OR lower(body) LIKE :q', q: "%#{params[:q].downcase}%")
    end
  end

  # GET /collaborations/1
  # GET /collaborations/1.json
  def show
  end

  # GET /collaborations/new
  def new
    @collaboration = Collaboration.new
  end

  # GET /collaborations/1/edit
  def edit
  end

  # POST /collaborations
  # POST /collaborations.json
  def create
    @collaboration = Collaboration.new(user_id: current_user.id, note_id: @note.id)

    respond_to do |format|
      if @collaboration.save
        format.html { redirect_to @collaboration, notice: 'Collaboration was successfully created.' }
        format.json { render :show, status: :created, location: @collaboration }
      else
        format.html { render :new }
        format.json { render json: @collaboration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collaborations/1
  # PATCH/PUT /collaborations/1.json
  def update
    return render json: {:error => "unauthorized"}, status: :unauthorized unless @collaboration.can_edit

    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collaborations/1
  # DELETE /collaborations/1.json
  def destroy
    return render json: {:error => "unauthorized"}, status: :unauthorized unless @collaboration.can_edit

    @collaboration.destroy
    respond_to do |format|
      format.html { redirect_to collaborations_url, notice: 'Collaboration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collaboration
      @collaboration = Collaboration.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_note_collaboration
      @note = Note.find(params[:id])
      @collaboration = Collaboration.where(note_id: @note.id, user_id: current_user.id).first
    end

    def set_note_vaidate
      unless collaboration_params[:uuid].nil? and collaboration_params[:password].nil?
        @note = Note.where(uuid: collaboration_params[:uuid], password: collaboration_params[:password]).first
      end
    end

    # Only allow a list of trusted parameters through.
    def collaboration_params
      params.require(:collaboration).permit(:note_id, :user_id, :uuid, :password)
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:title, :body)
    end

    def authorize_user
      return render json: {:error => "unauthorized"}, status: :unauthorized if @note.nil? || @note.user_id == current_user.id
      return render json: {:error => "existed!"}, status: 400 unless Collaboration.where(user_id: current_user.id, note_id: @note.id).first.nil?
    end
end
