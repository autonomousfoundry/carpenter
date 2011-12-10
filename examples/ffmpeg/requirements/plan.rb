require 'fileutils'

requirement :ffmpeg do
  verify do
    File.exists? "ffmpeg.installed"
  end
end

plan :ffmpeg do
  requires [{"requirement"=>"x264"}]
  build do
    puts "Pretending to compile and install ffmpeg"
    FileUtils.touch "ffmpeg.installed"
  end
end

requirement :x264 do
  verify do
    File.exists? "x264.installed"
  end
end

plan :x264 do
  build do
    puts "Pretending to compile and install x264"
    FileUtils.touch "x264.installed"
  end
end
