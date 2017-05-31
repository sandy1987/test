class Api::V1::FundsController < Api::V1::ApiController

  def available_fund
    render json: { available_fund: fund_to_be_withdraw }
  end

  def confirm_withdraw
    render json: { transfer_detail: transfer_detail(params[:amount], params[:payback_amount], params[:payback_date]) }
  end

  def netpay
  end

  def withdraw
    render json: { options: payment_options(params[:amount].to_f) }
  end

  private
    def date_at_next_no_of_weeks weeks
      Time.now.to_date + (7*weeks).days
    end

    def fund_to_be_withdraw
      total_fund = current_user.work_schedules.pluck(:amount).sum
      withdrawl_fund = Transaction.all.pluck(:amount).sum
      return (total_fund - withdrawl_fund)
    end

    def payment_options amount
      today_date = Time.now.to_date
      options = {}
      options[1] = { title: 'Pay Back on Current Pay Period', payment_date: [date_at_next_no_of_weeks(0)],pay_split: "$#{amount} + 5%($#{amount*5/100})", total: "#{amount+(amount*5/100)}" }
      options[2] = { title: 'Split Payment between 2 pay periods', payment_date: [date_at_next_no_of_weeks(0),date_at_next_no_of_weeks(1),date_at_next_no_of_weeks(2)], pay_split: "$#{amount} + 7%($#{amount*7/100})", total: "#{amount+(amount*7/100)}" }
      options[3] = { title: 'Pay Back on Next Pay Period', payment_date: [date_at_next_no_of_weeks(0),date_at_next_no_of_weeks(1)],pay_split: "$#{amount} + 10%($#{amount*10/100})", total: "#{amount+(amount*10/100)}" }
      return options
    end

    def transfer_detail amount, payback, payback_date
      { withdrawl_amount: amount, payback_amount: payback, payback_date: payback_date }
    end
end
