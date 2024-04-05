class RunService
  def self.same_time
    Product.first.update!(quantity: 50)
    4.times do |i|
      UpdateQuantityJob.perform_later(i + 1)
    end
    puts 'Job scheduled successfully!'
  end

  def self.same_time1
    Product.first.update!(quantity: 50)
    threads = []

    4.times do |i|
      threads << Thread.new do
        UpdateQuantityJob.perform_later(i + 1)
      end
    end

    # Wait for all threads to finish
    threads.each(&:join)

    puts 'Job scheduled successfully!'
  end
end
