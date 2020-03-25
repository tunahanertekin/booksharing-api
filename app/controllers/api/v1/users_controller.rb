module Api
    module V1
        class UsersController < ApplicationController

            def index
                users = User.all
                render json: {
                    status: 'SUCCESS', 
                    message: 'Users are loaded.',
                    data: users
                }
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
                        message: 'User is not found.',
                        data: []
                    }
                end
                
            end

            def create
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
                        message: "Error when adding a new user.",
                        data: []
                    }
                end
                
            end



            private def users_params
                params.require(:user).permit(:username, :email, :password, :title, :bookAmount, :buy, :sell, :score)
            end

        end
    end
end