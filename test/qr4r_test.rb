require "minitest/autorun"
require File.expand_path(File.join(File.dirname(__FILE__), "..", "init"))
require "tempfile"
class Qr4rTest < MiniTest::Test
  def test_encode
    # do something
    f = Tempfile.new(["qr4r", ".png"])
    Qr4r.encode("whatever yo", f.path)
    # assert that it worked
    assert File.exist?(f.path)
    r = MojoMagick.get_image_size(f.path)
    assert r[:height] == 25 * 3
    assert r[:width] == 25 * 3
  end

  def test_encode_with_size
    # do something
    f = Tempfile.new(["qr4r", ".png"])
    Qr4r.encode("whatever yo", f.path, size: 4)
    # assert that it worked
    assert File.exist?(f)
    r = MojoMagick.get_image_size(f.path)
    assert r[:height] == 33 * 3
    assert r[:width] == 33 * 3
  end

  def test_encode_with_size_and_border
    # do something
    f = Tempfile.new(["qr4r", ".png"])
    Qr4r.encode("whatever yo", f.path, size: 4, border: 10)
    # assert that it worked
    assert File.exist?(f)
    r = MojoMagick.get_image_size(f.path)
    assert r[:height] == (33 * 3) + 20
    assert r[:width] == (33 * 3) + 20
  end

  def test_encode_with_pixel_size
    # do something
    f = Tempfile.new(["qr4r", ".png"])
    Qr4r.encode("whatever yo", f.path, pixel_size: 5)
    # assert that it worked
    assert File.exist?(f)
    r = MojoMagick.get_image_size(f.path)
    assert r[:height] == 25 * 5
    assert r[:width] == 25 * 5
  end

  def test_encode_with_pixel_size_as_string
    # do something
    f = Tempfile.new(["qr4r", ".png"])
    Qr4r.encode("whatever yo", f.path, pixel_size: "5")
    # assert that it worked
    assert File.exist?(f)
    r = MojoMagick.get_image_size(f.path)
    assert r[:height] == 25 * 5
    assert r[:width] == 25 * 5
  end

  def test_encode_with_size_and_level
    # do something
    f = Tempfile.new(["qr4r", ".png"])
    Qr4r.encode("whatever yo", f.path, size: 4, level: :m)
    # assert that it worked
    assert File.exist?(f)
    r = MojoMagick.get_image_size(f.path)
    assert r[:height] == 33 * 3
    assert r[:width] == 33 * 3
  end

  def test_a_long_string_with_size_thats_too_small
    caught = false
    begin
      f = Tempfile.new(["qr4r", ".png"])
      Qr4r.encode("this string should also be encodable. don't ya think", f.path, size: 4)
    rescue StandardError
      caught = true
    end
    assert caught, "Expected an error"
  end

  def test_a_long_string_with_size_thats_right
    f = Tempfile.new(["qr4r", ".png"])
    Qr4r.encode("this string should also be encodable. don't ya think", f.path, size: 10)
    assert File.exist?(f)
    r = MojoMagick.get_image_size(f.path)
    assert r[:height] == 57 * 3
    assert r[:width] == 57 * 3
  end

  def test_a_long_string_without_size
    f = Tempfile.new(["qr4r", ".png"])
    Qr4r.encode("this string should also be encodable. don't ya think", f.path)
    assert File.exist?(f)
    r = MojoMagick.get_image_size(f.path)
    assert r[:height] = 41 * 3
    assert r[:width] = 41 * 3
  end

  def test_compute_size
    test_sizes = [7, 14, 24, 34, 44, 58, 64, 84, 98]
    test_sizes.each_with_index do |sz, idx|
      str = "a" * (sz - 1)
      assert Qr4r.send(:compute_size, str) == idx + 1
      str = "a" * sz
      assert Qr4r.send(:compute_size, str) == idx + 2
    end
  end

  def test_compute_size_too_big
    str = "a" * 120
    caught = false
    begin
      Qr4r.send(:compute_size, str)
    rescue StandardError => _e
      caught = true
    end
    assert caught, "Expected exception"
  end
end
