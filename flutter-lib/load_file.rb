p = Dir::open("ios_frameworks")
arr = Array.new
p.each do |f|
    if f == '.' || f == '..'
    else
        arr.push('ios_frameworks/'+f)     
    end
end

puts arr