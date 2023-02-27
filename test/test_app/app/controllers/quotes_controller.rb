class QuotesController < Rulers::Controller
  def index
    @quotes = FileModel.find_all

    render :index
  end

  def show
    @quote = FileModel.find(params["id"])

    render :show
  end

  def update
    raise "cannot update unless using POST" unless env['REQUEST_METHOD'] == 'POST'

    quote = FileModel.find(1)

    quote[:submitter] = 'Neil'

    quote.save
  end
end
