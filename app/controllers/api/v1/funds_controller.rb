class Api::V1::FundsController < Api::V1::ApiController

  def available_fund
    render json: { available_fund: fund_to_be_withdraw }
  end

  def confirm_withdraw
    render json: { transfer_detail: transfer_detail(params[:amount], params[:payback_amount], params[:payback_date]) }
  end

  def netpay
    render json: { detail: create_transaction_for_user(params[:amount].to_i).as_json }
  end

  def withdraw
    render json: { options: payment_options(params[:amount].to_f) }
  end

  private
    def create_transaction_for_user amount
      current_user.transactions.create(fund_after_tax_deduction(amount))
    end

    def date_at_next_no_of_weeks weeks
      Time.now.to_date + (7*weeks).days
    end

    def date_for_fund_type key
      case key
        when 1 then [date_at_next_no_of_weeks(0)]
        when 2 then [date_at_next_no_of_weeks(0),date_at_next_no_of_weeks(1),date_at_next_no_of_weeks(2)]
        when 3 then [date_at_next_no_of_weeks(0),date_at_next_no_of_weeks(1)]
      end
    end

    def get_data_for_option amount, key
      perc = percent(key)
      inter = intereset(amount, perc)
      { title: title_for_fund_type(key), payment_date: date_for_fund_type(key), amount: amount, percent: perc, interest: inter, pay_split: "$#{amount} + #{perc}%($#{inter})", total: "#{amount+inter}" }
    end

    def payment_options amount
      today_date = Time.now.to_date
      options = {}
      [1,2,3].map {|key| options[key] = get_data_for_option(amount, key) }
      return options
    end

    def percent key
      case key
        when 1 then 5
        when 2 then 7
        when 3 then 10
      end 
    end

    def title_for_fund_type key
      case key
        when 1 then 'Pay Back on Current Pay Period'
        when 2 then 'Split Payment between 2 pay periods'
        when 3 then 'Pay Back on Next Pay Period'
      end      
    end

    def transfer_detail amount, payback, payback_date
      { withdrawl_amount: amount, payback_amount: payback, payback_date: payback_date }
    end
end
