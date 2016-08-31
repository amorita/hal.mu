class CampaignsController < ApplicationController

layout 'priv'

def index
  @campaigns = Campaign.where('now() between start_at and end_at')
end

def show
  @campaign = Campaign.find params[:id]

  @vote = Vote.where(:user_id => current_user.id, :campaign_id => @campaign.id).first

  if @vote.nil?
    @vote = Vote.new
    @vote.user_id = current_user.id
    @vote.campaign_id = @campaign.id
    @vote.candidate_id = 0
  end

end

def update
  candidate_id = params['vote']
  campaign_id = params['id']
  vote = Vote.where(:user_id => current_user.id, :campaign_id => campaign_id).first

  if vote.nil?
    vote = Vote.new
    vote.user_id = current_user.id
    vote.campaign_id = campaign_id
  end

  vote.candidate_id = candidate_id

  vote.save!

  redirect_to action: 'index'
  
end

end