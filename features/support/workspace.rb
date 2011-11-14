class CucumberWorkspace
  attr_reader :directory

  def initialize(directory_name)
    @directory = directory_name
    FileUtils.mkdir_p @directory
    clear
    FileUtils.mkdir_p @directory
  end

  def clear
    FileUtils.rm_r @directory, :secure => true
  end

  def write(filename, content)
    FileUtils.mkdir_p File.join(@directory, File.dirname(filename))
    File.open(File.join(@directory, filename), "w") { |f| f << content }
  end

  def chdir
    Dir.chdir(@directory) { yield }
  end

  def exists?(filename)
    File.exists? File.join(@directory, filename)
  end
end
