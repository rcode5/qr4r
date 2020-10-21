require "rqrcode_core"
require "mojo_magick"
module Qr4r
  # These come from rqrcode_core - read https://github.com/whomwah/rqrcode_core
  # for more information
  SIZE_RESTRICTIONS = [0, 7, 14, 24, 34, 44, 58, 64, 84, 98, 119]

  def self.encode(str, outfile, *rest)
    opts = rest[0] unless rest.empty?
    opts ||= {}
    opts[:size] = compute_size(str) unless opts[:size]
    opts[:pixel_size] = 3 unless opts[:pixel_size]
    qr_code, data = build_qr_code(str, opts)
    create_image(qr_code, data, outfile, opts)
  end

  class << self
    private

    def build_qr_code(str, opts)
      qr = RQRCodeCore::QRCode.new(str, opts)
      data = [].tap do |px|
        qr.modules.each_index do |x|
          qr.modules.each_index do |y|
            if qr.checked?(x, y)
              3.times { px << 0 }
            else
              3.times { px << 255 }
            end
          end
        end
      end
      [qr, data]
    end

    def create_image(qr_code, data, outfile, opts)
      MojoMagick.convert do |c|
        d = data.pack "C" * data.size
        c.blob(d, format: :rgb, depth: 8, size: format("%dx%d", qr_code.modules.size, qr_code.modules.size))
        if opts[:pixel_size]
          wd = qr_code.modules.size * opts[:pixel_size].to_i
          c.scale format("%dx%d", wd, wd)
        end
        if opts[:border]
          border = opts[:border].to_i
          c.bordercolor "white"
          c.border format("%dx%d", border, border)
        end
        c.file outfile
      end
    end

    def compute_size(str)
      slen = str.size
      ii = 0
      while ii < SIZE_RESTRICTIONS.length
        break if slen < SIZE_RESTRICTIONS[ii]

        ii += 1
      end
      if ii > 10
        raise "Your string is too big for this encoder.  It should be less than #{SIZE_RESTRICTIONS.last} characters"
      end

      ii
    end
  end
end
