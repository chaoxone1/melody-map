module MarkersHelper
  def self.generate(events)
    # Ensure we only process geocoded events
    events.select(&:geocoded?).map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: ApplicationController.renderer.render(partial: "events/info_window",
                                                                locals: { event: event }),
        marker_html: ApplicationController.renderer.render(partial: "events/marker")
      }
    end
  end
end
