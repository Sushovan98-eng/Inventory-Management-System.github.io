class AppInterfaceController < ApplicationController
    before_action :admin_user, only:[:admin_panel]

    def index        
    end
    
    def admin_panel
    end

end
