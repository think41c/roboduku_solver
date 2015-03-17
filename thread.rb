20.times do |i|
  Thread.new do
    while true
    puts "I am Thread #{i}"
    sleep rand(3)
  end
end