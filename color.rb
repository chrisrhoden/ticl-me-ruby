module Color
  
  class RGB
    
    attr_accessor :red, :green, :blue
    {:red =>:r, :green => :g, :blue => :b}.each_pair do |name, aliasd|
      alias_method aliasd, name
      alias_method (aliasd.to_s + '=').intern, (name.to_s + '=').intern
    end
    
    def initialize(r,g,b)
      self.rgb = r, g, b
    end
    
    def to_cmyk
      temp     = []
      temp[0]  = 1 - (r/255.0)
      temp[1]  = 1 - (g/255.0)
      temp[2]  = 1 - (b/255.0)
      k = temp.min
      c = (temp[0] - k) / (1 - k)
      m = (temp[1] - k) / (1 - k)
      y = (temp[2] - k) / (1 - k)
      Color::CMYK.new(c,m,y,k)
    end
    
    def rgb
      [r,g,b]
    end
    
    def rgb=(rgb)
      @red, @green, @blue = *rgb
    end
    
  end
  
  class CMYK
    
    attr_accessor :cyan, :magenta, :yellow, :black
    
    {:cyan =>:c, :magenta => :m, :yellow => :y, :black => :k}.each_pair do |name, aliasd|
      alias_method aliasd, name
      alias_method (aliasd.to_s + '=').intern, (name.to_s + '=').intern
    end
    
    def initialize(c,m,y,k)
      self.cmyk = c, m, y, k
    end
    
    def to_rgb
      temp   = 1 - k
      r = temp * (1 - c) * 255;
      g = temp * (1 - m) * 255;
      b = temp * (1 - y) * 255;
      Color::RGB.new(r.round,g.round,b.round)
    end
    
    def cmyk=(cmyk)
      @cyan, @magenta, @yellow, @black = *cmyk
    end
    
  end
  
end

