  socket = io.connect "http://localhost"
  socket.on 'news', (data) -> 
    console.log(data)

