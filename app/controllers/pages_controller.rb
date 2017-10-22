require 'twitter'
require 'nokogiri'
require_relative "../sentiment"

class PagesController < ApplicationController
  before_action :twitter_init

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all
    @count = 20
    render :index, locals: { tweets: params[:tweets] }
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    username = params[:username]
    tweets = timeline_query username
    tweet_sentiment_list = get_sentiment(tweets)
    redirect_to :action => "index", :tweets => tweet_sentiment_list
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.fetch(:page, {})
    end

    # Load api info from xml file
    def twitter_init
      file = File.read("twitter_key.xml")
      xml = Nokogiri::XML(file)
      config = {
        consumer_key: xml.xpath("//key").text,
        consumer_secret: xml.xpath("//secret").text,
      }

      # Set up api client
      @client = Twitter::REST::Client.new(config)
    end

    def timeline_query(user='realDonaldTrump', count=@count)
      begin
        options = {count: count, include_rts: false}
        tweets = @client.user_timeline(user, options)
        tweets.map do |tweet|
          "Tweet: #{tweet.full_text}"
        end
      rescue
        return []
      end
    end
end
