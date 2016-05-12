class GuideController < ApplicationController

before_filter :authenticate_user!
layout 'priv'

def index
end

def terms
end

end


