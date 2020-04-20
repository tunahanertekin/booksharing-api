module Api
    module V1
        class ExchangesController < ApplicationController
            
            
            def index
                
                begin
                    user = User.find(params[:user_id])

                    exchangesCreated = user.exchanges
                    exchangesReceived = Exchange.all.select{ |item| item.toUser == params[:user_id].to_i }

                    allExchanges = exchangesCreated + exchangesReceived

                    #objectify the database items

                    render json: {
                        status: "SUCCESS",
                        message: "Exchanges are loaded.",
                        data: allExchanges
                    }

                rescue => exception
                    render json: {
                        status: "FAILED",
                        message: exception.message,
                        data: []
                    }
                end

            end




            def show

                begin
                    user = User.find(params[:user_id])
                    
                    begin
                        exchange = user.exchanges.find(params[:id])
                        
                        render json: {
                            status: "SUCCESS",
                            message: "Exchange is loaded.",
                            data: exchange
                        }
                    rescue => exception
                        render json: {
                            status: "FAILED",
                            message: exception.message,
                            data: []
                        }
                    end

                rescue => exception
                    render json: {
                        status: "FAILED",
                        message: exception.message,
                        data: []
                    }
                end

            end





            def create

                begin
                
                    user = User.find(params[:user_id])
                    
                    begin
                        
                        exchange = user.exchanges.create(exchange_params)

                        render json: {
                            status: "SUCCESS",
                            message: "A new exchange is created.",
                            data: exchange
                        }
                        
                    rescue => exception
                        render json: {
                            status: "FAILED",
                            message: exception.message,
                            data: []
                        }
                    end

                rescue => exception
                    render json: {
                        status: "FAILED",
                        message: exception.message,
                        data: []
                    }
                end
                

            end




            def destroy

                begin
                user = User.find(params[:user_id])
                    
                    begin

                        exchange = user.exchanges.find(params[:id])
                        exchange.destroy

                        render json: {
                            status: "SUCCESS",
                            message: "Exchange is deleted.",
                            data: exchange
                        }
                        
                    rescue => exception
                        render json: {
                            status: "FAILED",
                            message: exception.message,
                            data: []
                        }
                    end

                rescue => exception
                    render json: {
                        status: "FAILED",
                        message: exception.message,
                        data: []
                    }
                end

            end


            def removeAllExchanges

                begin
                    user = User.find(params[:user_id])

                    begin
                        user.exchanges.all.each do |ex|
                            ex.destroy
                        end
    
                        render json: {
                            status: "SUCCESS",
                            message: "All exchanges of this user is removed."
                        }
                    rescue => exception
                        render json: {
                            status: "FAILED",
                            message: exception.message
                        }
                    end
                    
                rescue => exception
                    render json: {
                        status: "SUCCESS",
                        message: exception.message
                    }
                end

            end




            private def exchange_params
                params.require(:exchange).permit(:user_id, :toUser, :booksOffered,  :booksWanted)
            end
            

        end
    end
end

