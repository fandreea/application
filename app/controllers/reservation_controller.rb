class ReservationController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:save, :delete]

  def show
      @date = params[:date] || Time.now.strftime("%d-%m-%Y")

      @slots_per_room = []

      @rooms = Room.pluck(:name)

      @room_names = []

      @rooms.each do |room|
          @room_names.push(room)
          @slots_per_room.push(Slot.where(date: @date, room: room).order(:start_hour))
      end
  end

   def management
      @date = params[:date] || Time.now.strftime("%d-%m-%Y")

      @slots_per_room = []

      @rooms = Room.pluck(:name)

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
              ((slot.start_hour < params[:start_time].to_i && params[:end_time].to_i < slot.end_hour)) ||
              ((slot.start_hour == params[:start_time].to_i && params[:end_time].to_i == slot.end_hour))
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

  def deleteroom
      @deletable = Room.find_by(name: params[:name])
      @deletable.destroy
      flash[:alert] = "Room deleted"
      redirect_to '/internal/management/'
  end

  def addroom
    if Room.exists?(name: params[:name])
      flash[:alert] = "Room already exists"
    else
      Room.create(name: params[:name])
      flash[:notice] = "Room created"
    end
    redirect_to '/internal/management/'
  end
end
