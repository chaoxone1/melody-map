class EventsFetcher
  def initialize(params, user)
    @params = params
    @user = user
  end

  def fetch
    events = Event.where('date >= ?', Date.today.beginning_of_day)
    events = filter_by_query(events)
    events = filter_by_category(events)
    filter_by_view(events)
  end

  private

  def filter_by_query(events)
    return events unless @params[:query].present?

    Event.search_by_name_and_category(@params[:query])
  end

  def filter_by_category(events)
    return events unless @params[:category].present?

    if @params[:category] == 'For You'
      preferred_categories = @user.categories.split(',')
      events.where(category: preferred_categories)
    else
      events.where(category: @params[:category])
    end
  end

  def filter_by_view(events)
    case @params[:view]
    when 'today'
      filter_today(events)
    when 'week'
      filter_week(events)
    when 'for_you'
      filter_for_you(events)
    else
      filter_default(events)
    end
  end

  def filter_today(events)
    events.where(date: Date.today.beginning_of_day..Date.today.end_of_day)
  end

  def filter_week(events)
    events.where(date: Date.today.beginning_of_week..Date.today.end_of_week)
  end

  def filter_for_you(events)
    preferred_categories = @user.categories
    events.where(category: preferred_categories)
  end

  def filter_default(events)
    events.limit(6)
  end
end
