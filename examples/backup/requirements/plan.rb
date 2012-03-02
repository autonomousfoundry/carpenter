# requirements.json
# [{"requirement": "backup"}]

require 'fileutils'

plan "backup" do
  requires [ {:requirement => "backup-home"},
             {:requirement => "backup-data"},
             {:requirement => "backup-www"}]
end

requirement "backup-home" do
  verify do
    File.exists? "home.remote.backup"
  end
end

plan "backup-home" do
  build do
    puts "Fake backup home folder"
    FileUtils.touch "home.remote.backup"
  end
end

requirement "backup-data" do
  verify do
    File.exists? "data.remote.backup"
  end
end

plan "backup-data" do
  build do
    puts "Fake backup data folder"
    FileUtils.touch "data.remote.backup"
  end
end

requirement "backup-www" do
  verify do
    File.exists? "www.remote.backup"
  end
end

plan "backup-www" do
  build do
    puts "Fake backup www folder"
    FileUtils.touch "www.remote.backup"
  end
  requires [ {:requirement => "backup-home"}]
end
