class JSONMiddleWare
  def self.load(string)
    if USE_INTERNAL_JSON
      JSON.parse(string)
    else
      Oj.load(string)
    end
  end

  def self.dump(string)
    if USE_INTERNAL_JSON
      JSON.generate(string)
    else
      Oj.dump(string)
    end
  end
end
