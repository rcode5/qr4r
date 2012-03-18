# QR Encoding via Ruby - with PNG output

Leveraging RQRCode and mojo_magick, we've built a very thin gem that generates QR codes in a png file

# Include in your project

In your 'Gemfile', add

    gem 'qr4r'

In your code, add
    
    require 'qr4r'

To use it:

    Qr4r::encode(input_string, output_file_path, size)

To encode the string 'qr codes are the new hotness' like this:
  
    string_to_encode = 'qr codes are the new hotness'
    Qr4r::encode(string_to_encode, 'qrcode.out.png')  

Not happy with the default size (99px x 99px)? Adjust the size with the 3rd argument to encode

    # the following produces an image who's size is 5x33 on a side or
    # 165px x 165px
    string_to_encode = 'big qr codes are the new hotness'
    Qr4r::encode(string_to_encode, 'qrcode.out.png', 5)  



