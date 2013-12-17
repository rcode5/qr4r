# QR Encoding via Ruby - with PNG output

Leveraging [rqrcode](http://whomwah.github.com/rqrcode/) and [mojo_magick](http://github.com/rcode5/mojo_magick), we've built a very thin gem that generates QR codes in a png file

# Include in your project

In your 'Gemfile', add

    gem 'qr4r'

In your code, add
    
    require 'qr4r'

NOTE: you'll need to have ImageMagick installed wherever you plan to run this.  The gem depends on [mojo_magick](http://github.com/rcode5/mojo_magick) which uses ImageMagick commandline operations to build the final PNG image.

To use it:

    Qr4r::encode(input_string, output_file_path, options)

*input_string* and *output_file_path* should be strings.  Options should a list of hash options keyed by symbols.  Possible options are:
 
 * :pixel_size  - specify the size of each 'black' dot in the qrcode.  Default = 3
 * :border - specify the number of pixels to use for a white border around the outside.  Default = 0

To encode the string 'qr codes are the new hotness' like this:

    require 'qr4r'
    s = 'qr codes are the new hotness'
    fname = s.gsub(/\s+/,"_") + ".qr.png"
    Qr4r::encode(s, fname)

Make a bigger QRCode

    s = 'big qr codes are the new hotness'
    fname = s.gsub(/\s+/,"_") + ".qr.png"
    Qr4r::encode(s, fname, :pixel_size => 5)

Add a fat border

    s = 'big qr codes are the new hotness with a border'
    fname = s.gsub(/\s+/,"_") + ".qr.png"
    Qr4r::encode(s, fname, :border => 20)

NOTE: The current implementation or rQRCode (and therefore this wrapper library) supports encoding up to 119 characters.  Beyond that, you'll need something a bit more sophisticated.

## Versions/Changelog

#### 0.4.0

* Moved to new mojo_magick gem
* no longer ruby 1.8.7 compatible
* fixed issue with border coming out black

## Authors

Original author: [Jon Rogers](http://github.com/bunnymatic) [at rcode5](http://www.rcode5.com)

Thanks to [Duncan Robertson](http://whomwah.github.com/rqrcode/) for writing rQRCode

## Contributing
* Fork the project
* Write a test for your new feature/method
* Send a pull request
* Don't bump the version or modify the gemspec. I'll do that when I merge in your mods and release a new version.

## Copyright

MIT Licence (http://www.opensource.org/licenses/mit-license.html)
