class Statistic
  attr_reader :data, :partition_size

  def self.count(objects, method)
    data = Hash.new(0)
    objects.each { |object| data[object.send(method)] += 1 }
    new data
  end

  def initialize(data, partition_size = 1)
    @data           = data
    @partition_size = partition_size
  end

  def partitioned(number_of_partitions)
    partition_size = largest_key.quo(number_of_partitions).ceil

    partitioned_data = {}.tap do |partitioned_data|
      # prefill the partitions with 0's - we want the keys to exist, even if
      # the values stay at zero, so Hash.new(0) is out.
      1.upto(number_of_partitions) do |partition|
        partitioned_data[partition * partition_size] = 0
      end

      # add in the data
      data.each do |key, value|
        partitioned_data[key.quo(partition_size).ceil * partition_size] += value
      end
    end

    Statistic.new(partitioned_data, partition_size)
  end

  private

  def largest_key
    data.keys.max
  end
end