class AddColumnToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :taxes, :integer
    add_column :transactions, :deduction, :integer
    add_column :transactions, :withdrawal, :integer
    add_column :transactions, :net_pay, :integer
  end
end
