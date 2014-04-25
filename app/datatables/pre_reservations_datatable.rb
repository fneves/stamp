  class PreReservationsDatatable

    delegate :params, :h, :link_to, to: :@view

    def initialize(view)
      @view = view
    end

    def as_json(options = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Stamp::PreReservation.count,
        iTotalDisplayRecords: pre_reservations.total_entries,
        aaData: data
      }
    end

  private

    def data
      pre_reservations.map do |pre_reservation|
        [


          pre_reservation.customer.try(:name),
          pre_reservation.stamp_service.try(:name),
          pre_reservation.stamp_time_slot.try(:from),
          pre_reservation.stamp_time_slot.try(:units),
          #TODO currency
          pre_reservation.try(:total_price),
          link_to('Show', [pre_reservation.stamp_service, pre_reservation]),
          link_to('Edit', :controller => 'pre_reservations', :action => 'edit', :service_id => pre_reservation.stamp_service.id, :id => pre_reservation.id),
          link_to("Delete", [pre_reservation.stamp_service, pre_reservation], method: :delete, data: { confirm: 'Are you sure?' })
        ]
      end
    end

    def pre_reservations
      @pre_reservations ||= fetch_pre_reservations
    end

    def fetch_pre_reservations
      pre_reservations = Stamp::PreReservation.joins(:stamp_service).joins(:customer).joins(:stamp_time_slot).order("#{sort_column} #{sort_direction}")

      pre_reservations = pre_reservations.page(page).per_page(per_page)

      if params[:sSearch].present?

        pre_reservations = Stamp::PreReservation.joins(:stamp_service).joins(:customer).joins(:stamp_time_slot).where('(users.name like ? or stamp_services.name like ? or stamp_time_slots."from" like ? or stamp_time_slots.units like ? or total_price like ?) ',  "%#{params[:sSearch]}%", "%#{params[:sSearch]}%", "%#{params[:sSearch]}%", "%#{params[:sSearch]}%", "%#{params[:sSearch]}%")

        pre_reservations = pre_reservations.page(page).per_page(per_page)
      end


      pre_reservations
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