module Api
    module V1
        class BooksController < ApplicationController

            def index

                begin
                    user = User.find(params[:user_id])
                    books = user.books
                    render json: {
                        status: 'SUCCESS', 
                        message: 'Books are loaded.',
                        data: books
                    }
                rescue => exception
                    render json: {
                        status: 'FAILED', 
                        message: 'User is not found.',
                        data: []
                    }
                end

                
            end

            def show
                begin
                    user = User.find(params[:user_id])

                    begin
                        book = user.books.find([params[:id]])

                        render json: {
                            status: 'Success',
                            message: 'Book is loaded.',
                            data: book
                        }

                    rescue => exception
                        render json: {
                            status: 'FAILED',
                            message: 'There is no such a book for this user.',
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
                        book = user.books.create(book_params)
                        render json: {
                            status: "SUCCESS",
                            message: "A new book is added to user's library.",
                            data: book
                        }
                    rescue => exception
                        render json: {
                            status: "FAILED",
                            message: "Error occurred when adding new book.",
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

            private def book_params
                params.require(:book).permit(:title, :author, :price, :user_id)
            end
        end

    end
end