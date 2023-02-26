class QuotesController < Rulers::Controller
  def index
    @quotes = FileModel.find_all

    render :index
  end
end
