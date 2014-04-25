  class ReservationsDatatable

    delegate :params, :h, :link_to, to: :@view

    def initialize(view)
      @view = view
    end

    def as_json(options = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Stamp::Reservation.count,
        iTotalDisplayRecords: reservations.total_entries,
        aaData: data
      }
    end

  private

    def data
      reservations.map do |reservation|
        [


          reservation.customer.try(:name),
          reservation.stamp_service.try(:name),
          reservation.stamp_time_slot.try(:from),
          reservation.stamp_time_slot.try(:units),
          #TODO currency
          reservation.try(:total_price),
          link_to('Show', [reservation.stamp_service, reservation]),
          link_to('Edit', :controller => 'reservations', :action => 'edit', :service_id => reservation.stamp_service.id, :id => reservation.id),
          link_to("Delete", [reservation.stamp_service, reservation], method: :delete, data: { confirm: 'Are you sure?' })
        ]
      end
    end

    def reservations
      @reservations ||= fetch_reservations
    end

    def fetch_reservations
      reservations = Stamp::Reservation.joins(:stamp_service).joins(:customer).joins(:stamp_time_slot).order("#{sort_column} #{sort_direction}")

      reservations = reservations.page(page).per_page(per_page)

      if params[:sSearch].present?

        reservations = Stamp::Reservation.joins(:stamp_service).joins(:customer).joins(:stamp_time_slot).where('(users.name like ? or stamp_services.name like ? or stamp_time_slots."from" like ? or stamp_time_slots.units like ? or total_price like ?) ',  "%#{params[:sSearch]}%", "%#{params[:sSearch]}%", "%#{params[:sSearch]}%", "%#{params[:sSearch]}%", "%#{params[:sSearch]}%")

        reservations = reservations.page(page).per_page(per_page)
      end


      reservations
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[users.name stamp_services.name stamp_time_slots."from" stamp_time_slots.units total_price]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end
  end