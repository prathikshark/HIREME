# app/services/booked_services_handler.rb
module Services
  # lib/services/booked_services_handler.rb
class BookedServiceManager
  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def create_booking
    if check_if_booking_present
      current_booking = Booking.create(customer_id: @current_user.customer.id)
      current_booking.save
    else
      current_booking = @current_user.customer.bookings.last
    end
    current_booking
  end

  def add_service
    filter_params = @params[:filter_params]
    return "Apply the filter first" unless filter_params

    from_date = filter_params[:from_date].to_date
    to_date = filter_params[:to_date].to_date

    return "To date cannot be greater than from date" if from_date > to_date

    current_booking = create_booking
    booked_services = current_booking.booked_services

    worker_id = @params[:worker_id].to_i
    if current_booking.booked_services.exists?(skill_type: filter_params[:skill_type])
      "Service already added"
    elsif booked_services.any? { |bs| bs.worker_id == worker_id && (bs.from_date <= to_date && bs.to_date >= from_date) }
      "There is a booking conflict for the selected worker and date range."
    else
      wage = calculate_wage(filter_params[:from_date], filter_params[:to_date], filter_params[:hours_per_day], filter_params[:skill_type], worker_id)
      booked_service = current_booking.booked_services.create(booking_service_params.merge(wage: wage))
      if booked_service.save
        "Service added"
      else
        "Could not add service"
      end
    end
  end

  private

  def check_if_booking_present
    @current_user.customer.bookings.any? && @current_user.customer.bookings.last.booked == true
  end

  def calculate_wage(from_date, to_date, hours_per_day, skill_type, worker_id)
    # Your wage calculation logic here
  end

  def booking_service_params
    @params.require(:filter_params).permit(:from_date, :to_date, :hour_per_day, :skill_type, :shift, :time)
          .merge(worker_id: @params[:worker_id])
  end
end

end