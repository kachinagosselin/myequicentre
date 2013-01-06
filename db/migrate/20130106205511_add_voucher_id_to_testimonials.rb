class AddVoucherIdToTestimonials < ActiveRecord::Migration
  def change
      add_column :testimonials, :voucher_id, :integer
  end
end
