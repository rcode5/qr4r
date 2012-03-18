require 'rqrcode'
require 'mojo_magick'
module Qr4r
  def self.encode(str, outfile)
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
      d = data.pack('C'*data.size.to_i)
      c.blob(data.pack(d, :format => :rgb, :depth => 8, :size => ("%dx%d" % [qr.modules.size, qr.modules.size])))
      c.file outfile
    end
  end
   
end
