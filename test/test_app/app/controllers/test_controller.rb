class TestController < Rulers::Controller
  def index
    @variable = 'variable'

    render :index
  end
end
