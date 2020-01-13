class Geo
  def initialize(db_path)
    @db = MaxMind::DB.new(db_path, mode: MaxMind::DB::MODE_MEMORY)
    define_finalizer
  end

  def get(ip)
    @db.get(ip)
  end

  private

  def define_finalizer
    ObjectSpace.define_finalizer(self, method(:finalize))
  end

  def finalize(_)
    @db.close
  end
end
