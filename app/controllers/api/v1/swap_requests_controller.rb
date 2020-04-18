module Api
    module V1

        class SwapRequestsController < ApplicationController




            def index
                begin
                    user = User.find(params[:user_id])
                    swapRequestsDb = user.swap_requests

                    swapRequests = Array.new
                    
                    swapRequestsDb.each do |req|

                        toUser = User.find(req.toUser)
                        booksOffered = Array.new
                        booksWanted = Array.new

                        req.booksOffered.split(",").each do |bookId|
                            booksOffered.push(user.books.find(bookId))
                        end

                        req.booksWanted.split(",").each do |bookId|
                            booksWanted.push(toUser.books.find(bookId))
                        end

                        #Find out if it's root request. If not, return it's ancestor
                        if req.ancestorRequest == 1
                            isRoot = true
                            ancestorRequest = {}
                        else
                            isRoot = false
                            begin
                                ancestorRequest = SwapRequest.find(req.ancestorRequest)
                            rescue => exception
                                ancestorRequest = {
                                    status: "missing",
                                    message: "Ancestor is missing."
                                }
                            end
                        end

                        #Find out if it's youngest child request in it's chain. If not, return it's child
                        if req.childRequest == 1
                            isYoungest = true
                            childRequest = {}
                        else
                            isYoungest = false
                            begin
                                childRequest = SwapRequest.find(req.childRequest)
                            rescue => exception
                                childRequest = {
                                    status: "missing",
                                    message: "Child is missing."
                                }
                            end
                        end

                        swapRequests.push({
                            id: req.id,
                            created_at: req.created_at,
                            isPending: req.isPending,
                            isAccepted: req.isAccepted,
                            user: user,
                            toUser: toUser,
                            booksOffered: booksOffered,
                            booksWanted: booksWanted,
                            isRoot: isRoot,
                            ancestorRequest: ancestorRequest,
                            isYoungest: isYoungest,
                            childRequest: childRequest,
                        })
                    end

                    render json: {
                        status: 'SUCCESS',
                        message: 'Swap requests are loaded.',
                        data: swapRequests
                    }
                rescue => exception
                    render json: {
                        status: 'FAILED',
                        message: exception.message,
                        data: []
                    }
                end
            end





            def show
                begin
                    user = User.find(params[:user_id])

                    begin
                        swapRequestDb = user.swap_requests.find([params[:id]])[0]

    
                        toUser = User.find(swapRequestDb.toUser)
                        booksOffered = Array.new
                        booksWanted = Array.new

                        swapRequestDb.booksOffered.split(",").each do |bookId|
                            booksOffered.push(user.books.find(bookId))
                        end

                        swapRequestDb.booksWanted.split(",").each do |bookId|
                            booksWanted.push(toUser.books.find(bookId))
                        end

                        #Find out if it's root request. If not, return it's ancestor
                        if swapRequestDb.ancestorRequest == 1
                            isRoot = true
                            ancestorRequest = {}
                        else
                            isRoot = false
                            begin
                                ancestorRequest = SwapRequest.find(swapRequestDb.ancestorRequest)
                            rescue => exception
                                ancestorRequest = {
                                    status: "missing",
                                    message: "Ancestor is missing."
                                }                                
                            end
                        end

                        #Find out if it's youngest child request in it's chain. If not, return it's child
                        if swapRequestDb.childRequest == 1
                            isYoungest = true
                            childRequest = {}
                        else
                            isYoungest = false
                            begin
                                childRequest = SwapRequest.find(swapRequestDb.childRequest)
                            rescue => exception
                                childRequest = {
                                    status: "missing",
                                    message: "Child is missing."
                                }
                            end
                        end

                        swapRequest = {
                            id: swapRequestDb.id,
                            created_at: swapRequestDb.created_at,
                            isPending: swapRequestDb.isPending,
                            isAccepted: swapRequestDb.isAccepted,
                            user: user,
                            toUser: toUser,
                            booksOffered: booksOffered,
                            booksWanted: booksWanted,
                            isRoot: isRoot,
                            ancestorRequest: ancestorRequest,
                            isYoungest: isYoungest,
                            childRequest: childRequest,
                        }

                        
                        render json: {
                            status: 'SUCCESS',
                            message: 'swap request is loaded.',
                            data: swapRequest
                        }

                    rescue => exception
                        render json: {
                            status: 'FAILED',
                            message: exception.message,
                            data: []
                        }
                    end


                rescue => exception
                    render json: {
                            status: 'FAILED',
                            message: 'User is not found.',
                            data: []
                        }
                end
                
            end





            def create
                begin
                    user = User.find(params[:user_id])

                    begin
                        swapRequest = user.swap_requests.create(swapRequest_params)
                        render json: {
                            status: "SUCCESS",
                            message: "A new swap request is added to user's library.",
                            data: swapRequest
                        }
                    rescue => exception
                        render json: {
                            status: "FAILED",
                            message: "Error occurred when adding new swap request.",
                            data: []
                        }
                    end
                    
                rescue => exception
                    render json: {
                        status: "FAILED",
                        message: "User is not found.",
                        data: []
                    }
                end

            end




            def update

                begin
                    user = User.find(params[:user_id])
                    
                    begin
                        swapRequest = user.swap_requests.find(params[:id])

                        begin
                            swapRequest.update(swapRequest_params)
                            render json: {
                                status: "SUCCESS",
                                message: "Swap request is updated.",
                                data: swapRequest
                            }
                        rescue => exception
                            render json: {
                                status: "FAILURE",
                                message: exception.message,
                                data: []
                            }
                        end
                       
                    rescue => exception
                        render json: {
                            status: "FAILURE",
                            message: exception.message,
                            data: []
                        }
                    end

                rescue => exception
                    render json: {
                        status: "FAILURE",
                        message: exception.message,
                        data: []
                    }
                end
            end




            def destroy
                begin

                    user = User.find(params[:user_id])
                    
                    begin
                        swapRequest = user.swap_requests.find(params[:id])

                        swapRequest.destroy
                        render json: {
                            status: "SUCCESS",
                            message: "Swap request is deleted.",
                            data: swapRequest
                        }

                    rescue => exception
                        render json: {
                            status: "FAILED",
                            message: "Swap request is not found.",
                            data: []
                        }
                    end
                    
                rescue => exception
                    render json: {
                        status: "FAILED",
                        message: "User is not found.",
                        data: []
                    }
                end
            end





            def receiving
                
                begin
                    toUser = User.find(params[:user_id])

                    swapRequestsDb = SwapRequest.all.select{ |item| item.toUser==params[:user_id].to_i }
                    
                    swapRequests = Array.new
                    
                    swapRequestsDb.each do |req|

                        user = User.find(req.user_id)
                        booksOffered = Array.new
                        booksWanted = Array.new

                        req.booksOffered.split(",").each do |bookId|
                            booksOffered.push(user.books.find(bookId))
                        end

                        req.booksWanted.split(",").each do |bookId|
                            booksWanted.push(toUser.books.find(bookId))
                        end

                        #Find out if it's root request. If not, return it's ancestor
                        if req.ancestorRequest == 1
                            isRoot = true
                            ancestorRequest = {}
                        else
                            isRoot = false
                            begin
                                ancestorRequest = SwapRequest.find(req.ancestorRequest)
                            rescue => exception
                                ancestorRequest = {
                                    status: "missing",
                                    message: "Ancestor is missing."
                                }
                            end
                        end

                        #Find out if it's youngest child request in it's chain. If not, return it's child
                        if req.childRequest == 1
                            isYoungest = true
                            childRequest = {}
                        else
                            isYoungest = false
                            begin
                                childRequest = SwapRequest.find(req.childRequest)
                            rescue => exception
                                childRequest = {
                                    status: "missing",
                                    message: "Child is missing."
                                }
                            end
                        end

                        swapRequests.push({
                            id: req.id,
                            created_at: req.created_at,
                            isPending: req.isPending,
                            isAccepted: req.isAccepted,
                            user: user,
                            toUser: toUser,
                            booksOffered: booksOffered,
                            booksWanted: booksWanted,
                            isRoot: isRoot,
                            ancestorRequest: ancestorRequest,
                            isYoungest: isYoungest,
                            childRequest: childRequest,
                        })
                    end

                    render json: {
                        status: 'SUCCESS',
                        message: 'Receiving swap requests are loaded.',
                        data: swapRequests
                    }

                rescue => exception
                    
                    render json: {
                        status: "FAILURE",
                        message: exception.message,
                        data: []
                    }

                end
                
                
            end




            def showReceiving

                begin
                    toUser = User.find(params[:user_id])

                    sr = SwapRequest.all.select{ |item| item.toUser==params[:user_id].to_i }
                    
                    swapRequestDb = sr.find{ |item| item.id==params[:id].to_i }

                    user = User.find(swapRequestDb.user_id)
                    booksOffered = Array.new
                    booksWanted = Array.new

                    swapRequestDb.booksOffered.split(",").each do |bookId|
                        booksOffered.push(user.books.find(bookId))
                    end

                    swapRequestDb.booksWanted.split(",").each do |bookId|
                        booksWanted.push(toUser.books.find(bookId))
                    end

                    #Find out if it's root request. If not, return it's ancestor
                    if swapRequestDb.ancestorRequest == 1
                        isRoot = true
                        ancestorRequest = {}
                    else
                        isRoot = false
                        begin
                            ancestorRequest = SwapRequest.find(req.ancestorRequest)
                        rescue => exception
                            ancestorRequest = {
                                status: "missing",
                                message: "Ancestor is missing."
                            }
                        end
                    end

                    #Find out if it's youngest child request in it's chain. If not, return it's child
                    if swapRequestDb.childRequest == 1
                        isYoungest = true
                        childRequest = {}
                    else
                        isYoungest = false
                        begin
                            childRequest = SwapRequest.find(req.childRequest)
                        rescue => exception
                            childRequest = {
                                status: "missing",
                                message: "Child is missing."
                            }
                        end
                    end

                    swapRequest = {
                        id: swapRequestDb.id,
                        created_at: swapRequestDb.created_at,
                        isPending: swapRequestDb.isPending,
                        isAccepted: swapRequestDb.isAccepted,
                        user: user,
                        toUser: toUser,
                        booksOffered: booksOffered,
                        booksWanted: booksWanted,
                        isRoot: isRoot,
                        ancestorRequest: ancestorRequest,
                        isYoungest: isYoungest,
                        childRequest: childRequest,
                    }

                    
                    render json: {
                        status: 'SUCCESS',
                        message: 'Receiving swap request is loaded.',
                        data: swapRequest
                    }
                rescue => exception
                    render json: {
                        status: 'Failure',
                        message: exception.message,
                        data: []
                    }
                end

                
            end




            def removeChain
                
                begin
                    deleteChain(params[:user_id], params[:id])
                    render json: {
                        status: "SUCCESS",
                        message: "Chain of this request is removed."
                    }
                rescue => exception
                    render json: {
                        status: "FAILED",
                        message: exception.message
                    }
                end
                

            end



            #this method deletes all chain
            private def deleteChain(user_id, id)

                youngestSwapRequest = SwapRequest.all.find(id)

                if youngestSwapRequest.ancestorRequest == 1
                    youngestSwapRequest.destroy
                    return
                else
                    ancestorId = youngestSwapRequest.ancestorRequest
                    youngestSwapRequest.destroy
                    return deleteChain(user_id, ancestorId)
                end

            end


            
            private def swapRequest_params
                params.require(:swapRequest).permit(:user_id, :toUser, :booksOffered, :booksWanted, :isPending, :isAccepted, :ancestorRequest, :childRequest)
            end

        end
    
    end
end
