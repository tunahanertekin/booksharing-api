

#get received requests
sr = SwapRequest.all.select{ |item| item.toUser==7 }

sr.each do |sr|
    sr.destroy
end

