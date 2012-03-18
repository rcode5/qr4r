require 'rqrcode'
require 'mojo_magick'
module Qr4r
  # size should indicate dot pixel size, size of 3 makes black pixels of 3x3
  def self.encode(str, outfile, size = 3)
    qr = RQRCode::QRCode.new(str)
    data = []
    qr.modules.each_index do |x|
      qr.modules.each_index do |y|
        if qr.dark?(x,y)
          3.times { data << 0 }
        else
          3.times { data << 255 }
        end
      end
    end
    MojoMagick::convert do |c|
      d = data.pack 'C'*data.size
      c.blob(d, :format => :rgb, :depth => 8, :size => ("%dx%d" % [qr.modules.size, qr.modules.size]))
      c.file outfile
    end
    MojoMagick::convert do |c| 
      c.file outfile
      c.scale "%dx%d" % [qr.modules.size, qr.modules.size].map{|s| s*size}
      c.file outfile
    end
  end
   
end
