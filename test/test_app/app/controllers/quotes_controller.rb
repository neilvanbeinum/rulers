class QuotesController < Rulers::Controller
  def index
    @quotes = FileModel.find_all

    render :index
  end

  def update
    raise "cannot update unless using POST" unless env['REQUEST_METHOD'] == 'POST'

    quote = FileModel.find(1)

    quote[:submitter] = 'Neil'

    quote.save
  end
end
