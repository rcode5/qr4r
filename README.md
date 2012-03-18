# QR Encoding via Ruby - with PNG output

Leveraging RQRCode and mojo_magick, we've built a very thin gem that generates QR codes in a png file

# Include in your project

In your 'Gemfile', add

    gem 'qr4r'

In your code, add
    
    require 'qr4r'

To use it:

    Qr4r::encode(input_string, output_file_path, size = 3)

*input_string* and *output_file_path* should be strings.  Size should be an integer from 1 - 10.  The final output size is square and will be 33 * size pixels.  e.g.  if size = 4, the image will be 132x132.  Default size is 3 (images are 99x99 pixels).

To encode the string 'qr codes are the new hotness' like this:
  
    string_to_encode = 'qr codes are the new hotness'
    Qr4r::encode(string_to_encode, 'qrcode.out.png')  

Not happy with the default size (99px x 99px)? Adjust the size with the 3rd argument to encode

    # the following produces an image who's size is 165px x 165px
    string_to_encode = 'big qr codes are the new hotness'
    Qr4r::encode(string_to_encode, 'qrcode.out.png', 5)  



