class SampleFileExists
  extend Carpenter::Provisioning

  verify :sample_file_exists do
    puts "verifying with options: #{options}"
  end
end
