class CommunitiesController < ApplicationController

  def index
    @communities = current_user.admin_communities + current_user.communities
  end

  def new
    @community = current_user.communities.build
  end

  def create
    @community = current_user.communities.build(community_params)
    respond_to do |format|
      if @community.save
        format.html { redirect_to user_path(current_user), notice: 'Community was successfully created.' }
        format.json { render action: 'show', status: :created, location: @community }
      else
        format.html { render action: 'new' }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end

  end


  private
    def community_params

    end

end
