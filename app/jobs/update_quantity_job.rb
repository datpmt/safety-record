class UpdateQuantityJob < ApplicationJob
  queue_as :default

  def perform(quantity)
    reduce_quantity(quantity)
    # reduce_with_lock(quantity)
  end

  private

  def reduce_quantity(quantity)
    Product.transaction do
      product = Product.first
      product.quantity -= quantity
      product.save!
    end
  end

  def reduce_with_lock(quantity)
    Product.transaction do
      product = Product.first
      product.with_lock do
        product.quantity -= quantity
        product.save!
      end
    end
  end
end
