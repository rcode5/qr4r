require 'test/unit'
require File::expand_path(File::join(File::dirname(__FILE__), '..', 'init'))
require 'tempfile'
class Qr4rTest < Test::Unit::TestCase

  def test_encode
    # do something
    f = Tempfile.new(['qr4r','.png'])
    Qr4r::encode('whatever yo', f.path)
    # assert that it worked
    assert File.exists?(f.path)
    r = MojoMagick::get_image_size(f.path)
    assert r[:height] == 99
    assert r[:width] == 99
  end

  def test_encode_with_size
    # do something
    f = Tempfile.new(['qr4r','.png'])
    Qr4r::encode('whatever yo', f.path, 4)
    # assert that it worked
    assert File.exists?(f)
    r = MojoMagick::get_image_size(f.path)
    assert r[:height] == 4 * 33
    assert r[:width] == 4 * 33
  end

  def test_a_long_string
    f = Tempfile.new(['qr4r','.png'])
    Qr4r::encode('this string should also be encodable. don\'t ya think', f.path, 4)
  end
end
