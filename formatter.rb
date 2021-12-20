$stdin.reopen("chorales.txt")

chorales = []
while line = gets
    chorales.push(line)
end
chorales.reverse
outputs = []
while chorale = chorales.pop
    chorale.gsub!(/\)\)\(/, '|')
    chorale.gsub!(/\)\)/, '')
    chorale.gsub!(/\(\d*\s\(\(\S*\s?/, '')
    chorale.gsub!(/\(*\(\S*/, '')
    chorale.gsub!(/\)/, ',')
    formatted = chorale.split('|')
    index = 0
    formatted.each do |e|
        if outputs.at(index) == nil
            outputs.push([])
        end
        outputs.at(index).push(e)
        index += 1
    end
end
outputs.reverse

notenumber = 86
while output = outputs.pop
    output.delete("\n")
    otptstr = "st, pitch, dur, keysig, timesig, fermata,\n"
    output.each {|piece| otptstr = otptstr + piece + "\n"}
    filename = "note" + notenumber.to_s + ".csv"
    File.open(filename, "w") do |f|
        f.write(otptstr)
    end
    notenumber -= 1
end
