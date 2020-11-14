class LinkController < ApplicationController
    def show
        @link = Link.find_by_slug(params[:slug])
        if @link.nil?
            render json: {error: "not found"}, status: 404 
        else
            @link.update_attribute(:clicked, @link.clicked + 1)
            redirect_to @link.url
        end
    end
    
    def new
        # params.permit(:url, :slug)
        @link = Link.shorten(params[:url], params[:slug])
        # binding.pry
        if @link
            render json: { linkData: @link, link: @link.short }, status: :ok
        else
            render json: {errors: 'error'}, status: 422
        end
    end

end