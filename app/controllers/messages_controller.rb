class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @event = Event.find(params[:event_id])
    @message.event = @event
    @message.user = current_user
    if @message.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:messages, partial: "messages/message",
            locals: { message: @message, user: current_user })
        end
        format.html { redirect_to event_path(@event) }
      end
    else
      render "event/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
