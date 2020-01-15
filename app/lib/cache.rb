class Cache
  attr_accessor :store

  def initialize(redis)
    @store = redis
  end

  def get_or_set(key, seconds: 0, &block)
    value = store.get(key)
    return value if value

    value = setnx(key, &block)
    store.expire(key, seconds)
    value
  end

  def setnx(key, &block)
    value = block.call
    store.setnx(key, value)
    value
  end
end
