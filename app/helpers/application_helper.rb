module ApplicationHelper

  def is_active_class? link
    controller = params[:controller]
    action = params[:action]
    case link.to_sym
      when :home
        ( controller == 'work_schedules' && %w(index next_schedule).include?(action) ? 'active' : '')
      when :schedule
        ( controller == 'work_schedules' && action == 'my_schedule') ? 'active' : ''
      when :withdraw
        ( action == 'withdraw') ? 'active' : ''
      when :netpay
        ( action == 'netpay') ? 'active' : ''
    end
  end

end
