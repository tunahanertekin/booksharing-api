module Api
    module V1
        class UsersController < ApplicationController

            def index
                begin
                    users = User.all
                    render json: {
                        status: 'SUCCESS', 
                        message: 'Users are loaded.',
                        data: users
                    }
                rescue => exception
                    render json: {
                        status: 'FAILED', 
                        message: exception.message,
                        data: users
                    }
                end
            end

            def show

                begin
                    user = User.find(params[:id])
                    render json: {
                        status: 'SUCCESS',
                        message: 'User is loaded.',
                        data: user
                    }
                rescue => exception
                    render json: {
                        status: 'FAILED',
                        message: exception.message,
                        data: []
                    }
                end
                
            end

            def create

                begin
                    user = User.new(users_params)

                    if user.save
                        render json: {
                            status: "SUCCESS",
                            message: "New user is added.",
                            data: user
                        }
                    else
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
                    user = User.find(params[:id])
                    user.destroy
                    
                    render json: {
                        status: "SUCCESS",
                        message: "User is deleted.",
                        data: user
                    }
                rescue => exception
                    render json: {
                        status: "FAILED",
                        message: exception.message,
                        data: user
                    }
                end
                  
            end


            private def users_params
                params.require(:user).permit(:username, :email, :password, :title, :bookAmount, :buy, :sell, :score)
            end

        end
    end
end