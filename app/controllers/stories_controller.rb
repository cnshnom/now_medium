class StoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_story, only: [:edit, :update, :destroy]


    def index
        @stories = current_user.stories.order(created_at: :desc)
      end

    def new
        @story = current_user.stories.new

    end

    def edit
    end

    def destroy
      @story.destroy
      redirect_to stories_path, notice: 'story was deleted!'
    end
  
    def update
        if @story.update(story_params)

          case
          when params[:publish]
            @story.publish!
            redirect_to stories_path, notice: 'published!'
          when params[:unpublish]
            @story.unpublish!
            redirect_to stories_path, notice: 'removed!'
          else 
            
            redirect_to edit_story_path(@story), notice: 'saved!'
          end
        
        else
          render :edit
        end
      end

    def create
        @story = current_user.stories.new(story_params)
        @story.publish! if params[:publish]


        if @story.save
          if params[:publish]
            redirect_to stories_path, notice: 'successfully published!'
          else
            redirect_to edit_story_path(@story), notice: 'successfully saved!'
          end


            
        else
          render :new
        end
    
    end

    private  

    def find_story
      @story = current_user.stories.friendly.find(params[:id])
    end


    def  story_params
        params.require(:story).permit(:title, :content, :cover_image)
    end
    
    




end
