require 'fileutils'

verify :ffmpeg do
  File.exists? "ffmpeg.installed"
end

build :ffmpeg do
  puts "Pretending to compile and install ffmpeg"
  FileUtils.touch "ffmpeg.installed"
end.requirements([{"requirement"=>"x264"}])

verify :x264 do
  File.exists? "x264.installed"
end

build :x264 do
  puts "Pretending to compile and install x264"
  FileUtils.touch "x264.installed"
end
