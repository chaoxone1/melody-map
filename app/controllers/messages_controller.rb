class MessagesController < ApplicationController
  def create
    @message = build_message
    if @message.save
      handle_success
    else
      handle_failure
    end
  end

  private

  def build_message
    message = Message.new(message_params)
    message.event = Event.find(params[:event_id])
    message.user = current_user
    message
  end

  def handle_success
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append(:messages, partial: "messages/message",
                                                            locals: { message: @message, user: current_user })
      end
      format.html { redirect_to event_path(@message.event) }
    end
  end

  def handle_failure
    render "event/show", status: :unprocessable_entity
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
