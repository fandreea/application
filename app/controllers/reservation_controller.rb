class ReservationController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:save, :delete]

  def show
      @date = params[:date] || Time.now.strftime("%d-%m-%Y")

      @slots_per_room = []

      @rooms = ["Meeting Room 1", "Meeting Room 2", "Conf Room 1", "Conf Room 2"]

      @room_names = []

      @rooms.each do |room|
          @room_names.push(room)
          @slots_per_room.push(Slot.where(date: @date, room: room).order(:start_hour))
      end
  end

  def save
      @other_slots = Slot.where(room: params[:room_name], date: params[:date])
      flag = false
      @other_slots.each do |slot|
          if ((slot.start_hour < params[:start_time].to_i) && (params[:start_time].to_i < slot.end_hour)) ||
              ((slot.start_hour < params[:end_time].to_i) && (params[:end_time].to_i < slot.end_hour)) ||
              (slot.start_hour < params[:start_time].to_i && params[:end_time].to_i < slot.end_hour)
              flag = true
          end
      end

      if flag
          flash[:alert] = "The selected time interval is not available"
      else
          Slot.create(date: params[:date], start_hour: params[:start_time], end_hour: params[:end_time], room: params[:room_name],
          user: params[:user], comment: params[:comment])
          flash[:notice] = "Reservation successful"
      end

      redirect_to '/reservation/show/' + params[:date]
  end

  def delete
      @deletable = Slot.find(params[:id])
      @deletable.destroy
      redirect_to '/reservation/show/' + params[:date]
  end
end
