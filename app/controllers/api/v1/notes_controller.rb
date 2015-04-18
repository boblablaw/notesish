class API::V1::NotesController < API::APIController
  before_action :authorize_api_key
  before_action :find_note, only: [:show, :update, :destroy]
  def index
    @notes = current_api_user.notes.ordered
  end

  def show
  end

  def create
    @note = current_api_user.notes.build note_params
    if @note.save
      render :show
    else
      render json: note.errors, status: :unprocessable_entity
    end
  end

  def update
    @note.update(note_params)
  end

  def destroy
    @note.destroy
  end

  private

  def note_params
    params.require(:note).permit(:title, :body_html)
  end

  def find_note
    @note = current_user.notes.find params[:id]
  end

end
