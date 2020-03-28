
imgArr = [
    "https://99designs-start-attachments.imgix.net/alchemy-pictures/2016%2F02%2F12%2F00%2F05%2F05%2F910db405-6bd4-4a5d-bce7-c2e3135dc5e6%2F449070_WAntoneta_55908c_killing.png?auto=format&ch=Width%2CDPR&fm=png&w=600&h=600",
    "https://marketplace.canva.com/MADSMNPt8uA/3/0/thumbnail_large/canva-green-beach-photo-book-cover-MADSMNPt8uA.jpg", 
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRjLLemgmSlmvioFdqXgubyAcD_u_uJFwpN04LLO1u1gzLUJVFL",
    "https://www.booktopia.com.au/blog/wp-content/uploads/2018/12/the-arsonist.jpg",
    "https://i.pinimg.com/originals/a4/aa/c1/a4aac1f3d86869bcfd2833e8be768014.jpg",
    "https://media2-747a.kxcdn.com/677-thickbox_default/book-cover.jpg",
    "https://static01.nyt.com/images/2019/12/22/books/review/22BestCovers-Dorfman-02/22BestCovers-Dorfman-02-mobileMasterAt3x.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQvrSV5ijKyboOtRTqmn4W-Cj7UM33_U3Wy405lf8dBeeG4SrDw",
    "https://images-na.ssl-images-amazon.com/images/I/41lnLrvBnML.jpg",
    "https://images-na.ssl-images-amazon.com/images/I/51eaZ1mO9ML._SX321_BO1,204,203,200_.jpg"
    ]


Book.all.each do |item|
    item.update(
        {
            imageSource: imgArr[rand(9)]
        }
    )
end

