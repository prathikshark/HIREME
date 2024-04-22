class AdminsController < ApplicationController
    def index

    end

    def all
        @admins = User.where(role: :admin)
      end
      
end
