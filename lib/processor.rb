class Processor
  
  def process(transactions)
    ordered = order_transactions_by_desc(transactions)
    processed = format_transactions(ordered, "")
  end

  private
    def format_transactions(transactions, destination_str)
      transactions.each do |record|
        date = format_date(record[:date])
        amount = format_amount(record[:type], record[:amount])
        balance = format_balance(record[:balance])
        destination_str << format_record(date, amount, balance)
      end
      destination_str
    end
    
    def format_date(date)
      date.strftime("%d/%m/%Y")
    end
    
    def format_amount(type, amount)
      type == :deposit ? '%0.2f ||' % amount : '|| %0.2f' % amount
    end
    
    def format_balance(balance)
      '%0.2f' % balance
    end
    
    def format_record(date, amount, balance)
      "#{date} || #{amount} || #{balance}" + "\n"
    end
    
    def order_transactions_by_desc(transactions)
      transactions.reverse
    end

end